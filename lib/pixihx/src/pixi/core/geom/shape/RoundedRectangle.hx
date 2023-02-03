package pixi.core.geom.shape;
import pixi.core.graphics.FillColor;
import pixi.core.graphics.GraphicsData;
import pixi.core.graphics.WebGLGraphicsData;
import pixi.util.Color;
import pixi.util.Constant.ShapeKind;

using Lambda;

/**
 * ...
 * @author leonaci
 */
class RoundedRectangle implements Shape {
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	public var radius:Float;
	public var kind(default, null):ShapeKind;
	
	public function new(?x:Float=0, ?y:Float=0, ?width:Float=0, ?height:Float=0, ?radius:Float=0) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.radius = radius;
		
		kind = ShapeKind.RoundedRectangle;
	}
	
	public function clone():RoundedRectangle {
		return new RoundedRectangle(x, y, width, height, radius);
	}
	
	public function copy(rrect:RoundedRectangle):RoundedRectangle {
		x = rrect.x;
		y = rrect.y;
		width = rrect.width;
		height = rrect.height;
		radius = rrect.radius;
		
		return this;
	}
	
	public function contains(x:Float, y:Float):Bool {
		if (width <= 0 || height <= 0) return false;
		
		if (this.x <= x && x <= this.x + width && this.y <= y && y <= this.y + height)
		{
			if (this.x + radius <= x && x <= this.x + width  - radius || this.y + radius <= y && y <= this.y + height - radius) return true;
			
			var dx = 0.0, dy = 0.0;
			switch [x, y] {
				case [x, y] if(x < this.x + radius && y < this.y + radius):
					dx = x - (this.x + radius);
					dy = y - (this.y + radius);
					
				case [x, y] if(x < this.x + radius && y < this.y + height - radius):
					dx = x - (this.x + radius);
					dy = y - (this.y + height - radius);
					
				case [x, y] if(x < this.x + width - radius && y < this.y + radius):
					dx = x - (this.x + width - radius);
					dy = y - (this.y + radius);
					
				case [x, y] if(x < this.x + width - radius && y < this.y + height - radius):
					dx = x - (this.x + width - radius);
					dy = y - (this.y + height - radius);
					
				case _: throw '!?';
			}
			return dx*dx+dy*dy<=radius*radius;
		}
		
		return false;
	}
	
	public function getBounds():Rectangle {
		return new Rectangle(x, y, width, height);
	}
	
	public function build(data:GraphicsData, webglData:WebGLGraphicsData):Void {
		var points = [];
		
		points.push(x);
		points.push(y + radius);
		
		quadBezierCurve(x                 , y + height - radius, x        , y + height, x         + radius, y + height         , points);
		quadBezierCurve(x + width - radius, y + height         , x + width, y + height, x + width         , y + height - radius, points);
		quadBezierCurve(x + width         , y          + radius, x + width, y         , x + width - radius, y                  , points);
		quadBezierCurve(x         + radius, y                  , x        , y         , x                 , y          + radius, points);
		
		var length = Std.int(points.length / 8);
		
		if (points[0] != points[points.length - 2] || points[1] != points[points.length - 1]) {
			points.push(points[0]);
			points.push(points[1]);
		}
		
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
				
				for (i in 0...4 * length) {
					[
						points[2 * i], points[2 * i + 1], r, g, b, a,
					].iter(e->vertices.push(e));
				}
				
				
				for (i in 1...2 * length) {
					[ 2 * i - 1 + vertPos, 2 * i - 1 + vertPos, 2 * i + vertPos, vertPos ].iter(e-> indices.push(e));
				}
				
				indices.push(4 * length - 1 + vertPos);
				indices.push(4 * length - 1 + vertPos);
			}
			case FillColor.None:
		}
		
		var line = new PolyLine(points);
		line.build(data, webglData);
	}
	
	static private inline function quadBezierCurve(fromX:Float, fromY:Float, cpX:Float, cpY:Float, toX:Float, toY:Float, points:Array<Float>) {
		var n = 20;
		
		var xa = 0.0;
		var ya = 0.0;
		var xb = 0.0;
		var yb = 0.0;
		var x  = 0.0;
		var y  = 0.0;
		
		var c = 0.0;
		for (i in 0...n + 1) {
			c = i / n;
			
			xa = (1-c) * fromX + c * cpX;
			ya = (1-c) * fromY + c * cpY;
			xb = (1-c) *   cpX + c * toX;
			yb = (1-c) *   cpY + c * toY;
			
			x  = (1-c) *    xa + c *  xb;
			y  = (1-c) *    ya + c *  yb;
			
			if(!(points.length >= 2 && points[points.length - 2] == x && points[points.length - 1] == y)) {
				points.push(x);
				points.push(y);
			}
		}
	}
}