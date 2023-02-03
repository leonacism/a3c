package q;
import q.Q;

/**
 * ...
 * @author leonaci
 */
private enum State<T> {
	Full(x:T, waitings:Array<{value:T, action:Cont<Dynamic>}>);
	Empty(waitings:Array<T->Cont<Dynamic>>);
}

abstract Box<T>(State<T>) {
	public function new(x:T=null) this = x==null? Empty([]) : Full(x, []);
	
	public inline function take():Cont<Dynamic> return Q.callCC(next -> {
		switch(this) {
			case Full(x, ws):
				if(ws.length>0) {
					var w = ws.shift();
					this = Full(w.value, ws);
					return Q.bind(Q.fork(w.action), _->Q.pure(x));
				}
				else {
					this = Empty([]);
					return Q.pure(x);
				}
			case Empty(ws):
				ws.push(b->next(b));
				this = Empty(ws);
				return Q.abort;
		}
	});
	
		public inline function put(x:T):Cont<Dynamic> return Q.callCC(next -> {
		switch(this) {
			case Full(v,ws):
				ws.push({value:x, action:cont->next(null)(cont)});
				this = Full(v,ws);
				return Q.abort;
			case Empty(ws):
				if (ws.length > 0) {
					var cont = ws.shift();
					this = Empty(ws);
					return Q.fork(cont(x));
				}
				else {
					this = Full(x,[]);
					return cont -> next(null)(cont);
				}
		}
	});
	
		public inline function peek() return switch(this) {
		case Full(x,_): x;
		case Empty(_): null;
	}
}