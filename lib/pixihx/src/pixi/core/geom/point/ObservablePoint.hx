package pixi.core.geom.point;
import pixi.core.util.Observer;

/**
 * ...
 * @author leonaci
 */
class ObservablePoint extends Observer<Dynamic> {
	public var x(default, set):Float;
	inline function set_x(x:Float):Float {
		this.x = x;
		notify(null);
		return x;
	}
	public var y(default, set):Float;
	inline function set_y(y:Float):Float {
		this.y = y;
		notify(null);
		return y;
	}

	inline public function new(handler:Void->Void, ?x:Float = 0, ?y:Float = 0) {
		super();
		
		this.x = x;
		this.y = y;
		observe(cast handler);
	}
	
	public function clone():Point return new Point(x, y);
	
	public function copy(p:Point):Void {
		this.x = p.x;
		this.y = p.y;
	}
	
	public static inline function eq(a:Point, b:Point):Bool return a.x == b.x && a.y == b.y;
}