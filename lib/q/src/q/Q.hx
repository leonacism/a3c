package q;
import q.Box;
import haxe.Timer;
import haxe.macro.Expr;

/**
 * ...
 * @author leonaci
 */
// C a
typedef Cont<A> = (A -> Dynamic) -> Dynamic;

enum Cmd {
	ACTION(action:Dynamic->Cmd);
	FORK(fork:Array<Cmd>);
	STOP(stop:Bool);
}

class Q {
	// pure :: a -> C a
	static public function pure<A>(a:A):Cont<A> return cb->cb(a);
	// (>>=) :: C a -> (a -> C b) -> C b
	static public function bind<A,B>(a:Cont<A>,f:A->Cont<B>):Cont<B> return cb->a(x->f(x)(y->cb(y)));
	static public function callCC<A,B>(k:(A->Cont<B>)->Cont<A>):Cont<A> return cb->k(x->_->cb(x))(cb);

	static public function run(process:Cont<Dynamic>):Void {
		var task = [ACTION(_->process(abort))];
		while(task.length>0) {
			switch(task.shift()) {
				case ACTION(action):
					var a:Cmd = action(null);
					if(a!=null) task.push(a);
				case FORK(fork):
					task = task.concat(fork);
				case STOP(stop):
			}
		}
	}
	
	static public function wait(ms:Int):Cont<Dynamic> {
		var box = new Box();
		Timer.delay(()->Q.run(box.put(null)), ms);
		return box.take();
	}
	
	static public var abort:Cont<Dynamic> = _->Cmd.STOP(true);
	
	static public var fork:Cont<Dynamic>->Cont<Dynamic> = p -> cb -> FORK([ACTION(cb), ACTION(_->p(abort))]);
	
	macro public static function build(e:Expr):Expr return buildexpr(e);
	
	static private function buildexpr(e:Expr):Dynamic {
		switch(e.expr) {
			case EBlock(es):
				es.reverse();
				
				var f = macro ${buildexpr(es.shift())};
				for(e in es) {
					f = switch(e.expr) {
						case EVars(vs):
							vs.reverse();
							
							for(v in vs) {
								var name = v.name;
								f = v.expr!=null?
									switch(v.expr.expr) {
										case ExprDef.EReturn(e):
											macro Q.bind($e, $name->$f);
											
										case _:
											macro {var $name = ${v.expr}; $f;}
									}:
									macro {var $name; $f;}
							}
							
							macro $f;
							
						case _:
							var e = buildexpr(e);
							macro Q.bind($e, _->$f);
					}
				}
				
				return macro $f;
				
			case EFor(it, e):
				switch(it.expr) {
					case EBinop(op, e1, e2) if(op.equals(OpIn)):
						var e = buildexpr(e);
						var e1 = switch(e1.expr) {
							case EConst(c):
								switch(c) {
									case Constant.CIdent(s): s;
									case _: throw '!?';
								}
							case _: throw '!?';
						}
						
						var e2 = switch(e2.expr) {
							case EBinop(op, _, _) if(op.equals(OpInterval)):
								macro $e2;
								
							case EConst(c):
								switch(c) {
									case Constant.CIdent(s):
										macro $e2.iterator();
									case _: throw '!?';
								}
							case _: throw '!?';
						}
						
						return macro {
							var a = $e2;
							var l = null;
							(l=()->
								a.hasNext()? Q.bind(Q.bind(Q.pure(a.next()), $e1->$e), _->l()) : Q.pure(null)
							)();
						}
						
					case _: throw '!?';
				}
				
			case EIf(c, eif, eelse):
				var eif = buildexpr(eif);
				var eelse = eelse!=null? buildexpr(eelse) : macro Q.pure(null);
				return macro ($c? $eif : $eelse);
				
			case EWhile(c, e, normalWhile):
				var e = buildexpr(e);
				
				return macro {
					var l = null;
					(l=()->
						$c? Q.bind($e, _->l()) : Q.pure(null)
					)();
				}
				
			case EReturn(cont):
				return macro $cont;
				
			case EBinop(op, e1, e2) if(op.equals(OpAssign)):
				var e2 = switch(e2.expr) {
					case EReturn(cont): macro $cont;
					case _: macro Q.pure($e2);
				}
				return macro Q.bind($e2, x->{$e1 = x; Q.pure(null); });
				
			case EVars(vs):
				vs.reverse();
				
				var f = macro Q.pure(null);
				for(v in vs) {
					var name = v.name;
					f = v.expr!=null?
						switch(v.expr.expr) {
							case ExprDef.EReturn(e):
								macro Q.bind($e, $name->$f);
								
							case _:
								macro {var $name = ${v.expr}; $f;}
						}:
						macro {var $name; $f;}
				}
				
				return macro $f;
				
			case _:
				return macro {$e; Q.pure(null);}
				
		}
	}
}