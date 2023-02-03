package rigid.dynamics.body;

/**
 * ...
 * @author leo
 */
abstract BodyList(Array<Body>) {
	inline function new(b:Array<Body>) this = b; 
	
	@:from
	static public inline function from(b:Array<Body>) return new BodyList(b);

	public inline function iterator() return this.iterator();

	public inline function addBody(b:Body) this.push(b);
	
	public inline function removeBody(b:Body) this.remove(b);
	
	public inline function integrate(dt:Float) {
		for(b in this) {
			b.integrate(dt);
			b.sync();
		}
	}
	
	public inline function length() return this.length;
}