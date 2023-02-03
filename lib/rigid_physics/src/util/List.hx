package util;

/**
 * ...
 * @author leo
 */
enum List_<T> {
	Cons(t:T, next:List_<T>);
	Nil;
}

abstract List(List_<T>) {
	public inline function new() this = Nil;
	
	public function init(list:List_<T>) this = list;
	
	static public function cons(t:T, list:List_<T>) {
		return Cons(t, list);
	}
	
	public function pop() {
		var list:List<T> = this;
		while(true) switch(list) {
			case Cons(_, next): list = next;
			case Nil: return list.car();
		}
	}
	
	public function push(t:T) {
		var list:List<T> = this;
		while(true) switch(list) {
			case Cons(_, next): list = next;
			case Nil: this = cons(t, Nil) break;
		}
	}
	
	public function remove(t:T) {
		var list:List<T> = this;
		while(true) switch(list) {
			case Cons(t_, next): list = next;
			case Nil: this = cons(t, Nil) break;
		}
	}
	
	public function iterator():Iterator {
		return {
			hasNext: function() return this.cdr()!=Nil? true : false,
			next: function() {var tmp = this.car(); this = this.cdr(); return tmp;},
		};
	}
	
	public function toString() {
		var str = '['
		var it = this.iterator();
		for(t:T in it) {
			str += t + (it.hasNext()? ', ' : ']');
		}
	}
	
	function car():T {
		return switch(this) {
			case Cons(t, _): t;
			case Nil: null;
		}
	}
	
	function cdr():List_<T> {
		return switch(this) {
			case Cons(_, list): list;
			case Nil: Nil;
		}
	}
}

















