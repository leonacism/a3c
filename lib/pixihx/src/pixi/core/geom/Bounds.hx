package pixi.core.geom;
import pixi.core.geom.shape.Rectangle;
import pixi.core.geom.transform.ITransform;
import pixi.util.MathUtil;

/**
 * ...
 * @author leonaci
 */
class Bounds {
	public var minX:Float;
	public var minY:Float;
	public var maxX:Float;
	public var maxY:Float;
	
	private var rect:Rectangle;
	
	public function new() {
		clear();
		rect = null;
	}
	
	public inline function isEmpty() {
		return minX > maxX || minY > maxY;
	}
	
	public inline function clear():Void {
		minX = MathUtil.POSITIVE_INFINITY;
		minY = MathUtil.POSITIVE_INFINITY;
		maxX = MathUtil.NEGATIVE_INFINITY;
		maxY = MathUtil.NEGATIVE_INFINITY;
	}
	
	public inline function getRectangle():Rectangle {
		if (isEmpty()) return Rectangle.EMPTY;
		
		return new Rectangle(minX, minY, maxX - minX, maxY - minY);
	}
	
	public inline function addBounds(bounds:Bounds):Void {
		this.minX = this.minX < bounds.minX? this.minX : bounds.minX; 
		this.minY = this.minY < bounds.minY? this.minY : bounds.minY; 
		this.maxX = bounds.maxX < this.maxX? this.maxX : bounds.maxX; 
		this.maxY = bounds.maxY < this.maxY? this.maxY : bounds.maxY; 
	}
	
	public inline function addQuad(vertices:Array<Float>):Void {
		var x = vertices[0];
		var y = vertices[1];
		
		minX = x < minX? x : minX;
		minY = y < minY? y : minY;
		maxX = maxX < x? x : maxX;
		maxY = maxY < y? y : maxY;
		
		x = vertices[2];
		y = vertices[3];
		
		minX = x < minX? x : minX;
		minY = y < minY? y : minY;
		maxX = maxX < x? x : maxX;
		maxY = maxY < y? y : maxY;
		
		x = vertices[4];
		y = vertices[5];
		
		minX = x < minX? x : minX;
		minY = y < minY? y : minY;
		maxX = maxX < x? x : maxX;
		maxY = maxY < y? y : maxY;
		
		x = vertices[6];
		y = vertices[7];
		
		minX = x < minX? x : minX;
		minY = y < minY? y : minY;
		maxX = maxX < x? x : maxX;
		maxY = maxY < y? y : maxY;
	}
	
	public inline function addFrame(transform:ITransform,  left:Float, top:Float, right:Float, bottom:Float):Void {
		var g = transform.global;
		var a = g.a, b = g.b, tx = g.tx,
			c = g.c, d = g.d, ty = g.ty;
		
		var x = a * left + b * top + tx;
		var y = c * left + d * top + ty;
		
		minX = x < minX? x : minX;
		minY = y < minY? y : minY;
		maxX = maxX < x? x : maxX;
		maxY = maxY < y? y : maxY;
		
		x = a * left + b * bottom + tx;
		y = c * left + d * bottom + ty;
		
		minX = x < minX? x : minX;
		minY = y < minY? y : minY;
		maxX = maxX < x? x : maxX;
		maxY = maxY < y? y : maxY;
		
		x = a * right + b * top + tx;
		y = c * right + d * top + ty;
		
		minX = x < minX? x : minX;
		minY = y < minY? y : minY;
		maxX = maxX < x? x : maxX;
		maxY = maxY < y? y : maxY;
		
		x = a * right + b * bottom + tx;
		y = c * right + d * bottom + ty;
		
		minX = x < minX? x : minX;
		minY = y < minY? y : minY;
		maxX = maxX < x? x : maxX;
		maxY = maxY < y? y : maxY;
	}
}