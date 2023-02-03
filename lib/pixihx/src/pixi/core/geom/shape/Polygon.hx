package pixi.core.geom.shape;
import pixi.core.geom.point.Point;
import pixi.core.graphics.FillColor;
import pixi.core.graphics.GraphicsData;
import pixi.core.graphics.WebGLGraphicsData;
import pixi.util.Color;
import pixi.util.Constant.ShapeKind;
import pixi.util.MathUtil;

using Lambda;

/**
 * ...
 * @author leonaci
 */
class Polygon implements Shape
{
	public var points(default,null):Array<Float>;
	
	public var closed(get, never):Bool;
	inline function get_closed():Bool return points.length > 2 && points[0] == points[points.length - 2] || points[1] == points[points.length - 1];
	
	public var kind(default, null):ShapeKind;
	
	public function new(points:Array<Point>) {
		this.points = [];
		
		for(p in points) {
			this.points.push(p.x);
			this.points.push(p.y);
		}
		
		kind = ShapeKind.Polygon;
	}
	
	public function clone():Polygon {
		return new Polygon([for(i in 0...Std.int(points.length/2)) new Point(points[2*i], points[2*i+1])]);
	}
	
	public function copy(poly:Polygon):Void {
		points = poly.points.copy();
	}
	
	public function close():Void {
		if(!closed) {
			points.push(points[0]);
			points.push(points[1]);
		}
	}
	
	public function contains(x:Float, y:Float):Bool {
		var inside = false;
		
		var length = Std.int(points.length/2);
		
		var i = length - 1;
		for (j in 0...length) {
			var x1 = points[2*i    ];
			var y1 = points[2*i + 1];
			var x2 = points[2*j    ];
			var y2 = points[2*j + 1];
			i = j;
			
			var intersect = 
				if ((y < y1) == (y < y2) || MathUtil.max(x1, x2) <= x) false;
				else if(x < MathUtil.min(x1, x2)) true;
				else if((x-x1)*(y2-y1)<=(y-y1)*(x2-x1)) true;
				else false;
			
			if(intersect) inside != inside;
		}
		
		return inside;
	}
	
	public function getBounds():Rectangle {
		var minX = MathUtil.POSITIVE_INFINITY;
		var minY = MathUtil.POSITIVE_INFINITY;
		var maxX = MathUtil.NEGATIVE_INFINITY;
		var maxY = MathUtil.NEGATIVE_INFINITY;
		
		for (i in 0...Std.int(points.length / 2)) {
			var x = points[2*i];
			var y = points[2*i + 1];
			
			minX = x<minX? x : minX;
			minY = y<minY? y : minY;
			maxX = maxX<x? x : maxX;
			maxY = maxY<y? y : maxY;
		}
		
		return new Rectangle(minX, minY, maxX-minX, maxY-minY);
	}
	
	static public function fromArray(points:Array<Float>):Polygon {
		return new Polygon([for(i in 0...Std.int(points.length/2)) new Point(points[2*i], points[2*i+1])]);
	}
	
	public function build(data:GraphicsData, webglData:WebGLGraphicsData):Void {
		var points = this.points.slice(0);
		
		switch(data.fillColor) {
			case FillColor.Fill(color) if (points.length >= 6):
			{
				var vertices = webglData.vertices;
				var indices = webglData.indices;
				
				var vertPos = Std.int(vertices.length / 6);
				
				var length = closed? Std.int(points.length / 2) - 1 : Std.int(points.length / 2);
				
				var a = color.a;
				var r = color.r * a;
				var g = color.g * a;
				var b = color.b * a;
				
				for (i in 0...length) {
					[points[2 * i], points[2 * i + 1], r, g, b, a].iter(e-> vertices.push(e));
				}
				
				// びみょい
				if(length % 2 != 0) {
					for (i in 1...Std.int(length + 1 / 2)) {
						[ 2 * i - 1 + vertPos, 2 * i - 1 + vertPos, 2 * i + vertPos, vertPos ].iter(e-> indices.push(e));
					}
				}
				else {
					for (i in 1...Std.int(length / 2)) {
						[ 2 * i - 1 + vertPos, 2 * i - 1 + vertPos, 2 * i + vertPos, vertPos ].iter(e-> indices.push(e));
					}
					
					indices.push(length - 1 + vertPos);
					indices.push(length - 1 + vertPos);
				}
			}
			case _:
		}
		
		var line = new PolyLine(points);
		line.build(data, webglData);
	}
}