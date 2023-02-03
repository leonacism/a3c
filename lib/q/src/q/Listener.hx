package q;

/**
 * ...
 * @author leonaci
 */
abstract Listener<T>(Box<T>) {
	public inline function new() this = new Box<T>();
	
	public inline function wait() Q.run(Q.build({
		return this.take();
	}));
	
	public inline function emit(data:T) return Q.build({
		return this.put(data);
	});
}