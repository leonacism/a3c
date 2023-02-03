package pixi.core.geom.point;

/**
 * ...
 * @author leonaci
 */
class Point {
	public var x:Float;
	public var y:Float;

	inline public function new(?x:Float = 0, ?y:Float = 0) {
		this.x = x;
		this.y = y;
	}
	
	public function clone():Point return new Point(x, y);
	
	public function copy(p:Point):Void {
		this.x = p.x;
		this.y = p.y;
	}
	
	public static inline function eq(a:Point, b:Point):Bool return a.x == b.x && a.y == b.y;
}