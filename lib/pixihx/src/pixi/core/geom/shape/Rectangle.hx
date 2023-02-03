package pixi.core.geom.shape;
import pixi.core.geom.point.Point;
import pixi.core.graphics.FillColor;
import pixi.core.graphics.GraphicsData;
import pixi.core.graphics.WebGLGraphicsData;
import pixi.util.Color;
import pixi.util.Constant.ShapeKind;

using Lambda;

/**
 * the basic rectangle class.
 *        (x, y)        (x + width, y)
 *          + - - - - - - +
 *          |             |
 *          |             |
 *          |             |
 *          |             |
 *          + - - - - - - +
 *  (x, y + height)    (x + width, y + height)
 * @author leonaci
 */
class Rectangle implements Shape {
	@:extern static public var EMPTY(get, never):Rectangle;
	inline static function get_EMPTY() return new Rectangle(0, 0, 0, 0);
	
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	
	public var kind(default, null):ShapeKind;
	
	public var left(get, never):Float;
	inline function get_left():Float return x;
	
	public var right(get, never):Float;
	inline function get_right():Float return x+width;
	
	public var top(get, never):Float;
	inline function get_top():Float return y;
	
	public var bottom(get, never):Float;
	inline function get_bottom():Float return y+height;
	
	public function new(?x:Float = 0, ?y:Float = 0, ?width:Float = 0, ?height:Float = 0) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		kind = ShapeKind.Rectangle;
	}
	
	public function clone():Rectangle {
		return new Rectangle(x, y, width, height);
	}
	
	public function copy(rect:Rectangle):Rectangle {
		x = rect.x;
		y = rect.y;
		width = rect.width;
		height = rect.height;
		
		return this;
	}
	
	public function contains(x:Float, y:Float):Bool {
		if (width <= 0 || height <= 0) return false;
		
		return (left <= x && x <= right && top <= y && y <= bottom)? true : false;
	}
	
	public function getBounds():Rectangle {
		return this.clone();
	}
	
	public function build(data:GraphicsData, webglData:WebGLGraphicsData):Void {
		
		switch(data.fillColor) {
			case FillColor.Fill(color):
			{
				var vertices = webglData.vertices;
				var indices = webglData.indices;
				
				var vertPos = Std.int(vertices.length / 6);
				
				var a = color.a;
				var r = color.r * a;
				var g = color.g * a;
				var b = color.b * a;
				
				[
					x        , y         , r, g, b, a,
					x + width, y         , r, g, b, a,
					x        , y + height, r, g, b, a,
					x + width, y + height, r, g, b, a,
				].iter(e-> vertices.push(e));
				
				[
					vertPos    , vertPos    , vertPos + 1,
					vertPos + 2, vertPos + 3, vertPos + 3,
				].iter(e-> indices.push(e));
			}
			case FillColor.None:
		}
		
		var points = [
			x        , y         ,
			x + width, y         ,
			x + width, y + height,
			x        , y + height,
			x        , y         ,
		];
		
		var line = new PolyLine(points);
		line.build(data, webglData);
	}
}