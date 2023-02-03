package a3c.ai.common;
import haxe.macro.Context;
import haxe.macro.Expr;

/**
 * ...
 * @author leonaci
 */
class Debug {
	
	macro static public function debuglocal() {
		var exprs = [];
		for (v in Context.getLocalTVars()) {
			var expr = macro str += $v{v.name} + ' : ' + $i{v.name} + '\n';
			exprs.push(expr);
		}
		
		var method = Context.getLocalMethod();
		
		return macro {
			var str = 'called from ${$v{method}}\n';
			$b{exprs};
			trace(str + '---------\n');
		};
	}
	
	macro static public function bench(target:Expr):Expr {
		return macro {
			var time = Date.now().getTime();
			$target;
			trace((Date.now().getTime()- time) + "ms");
		}
	}
}