package pixi.core.geom.shape;
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
class Circle implements Shape
{
	public var x:Float;
	public var y:Float;
	public var radius:Float;
	public var kind(default, null):ShapeKind;
	
	public function new(?x:Float=0, ?y:Float=0, ?radius:Float=0) {
		this.x = x;
		this.y = y;
		this.radius = radius;
		
		kind = ShapeKind.Circle;
	}
	
	public function clone():Circle {
		return new Circle(x, y, radius);
	}
	
	public function contains(x:Float, y:Float):Bool {
		if (radius <= 0) return false;
		
		var dx = this.x - x;
		var dy = this.y - y;
		
		return dx*dx+dy*dy<=radius*radius;
	}
	
	public function getBounds():Rectangle {
		return new Rectangle(x - radius, y - radius, 2 * radius, 2 * radius);
	}
	
	public function build(data:GraphicsData, webglData:WebGLGraphicsData):Void {
		var totalSegs = MathUtil.floor(30 * MathUtil.sqrt(radius));
		var seg = MathUtil.PI * 2 / totalSegs;
		
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
					x, y, r, g, b, a,
				].iter(e->vertices.push(e));
				
				for (i in 0...totalSegs) {
					[
						x + MathUtil.sin(seg * i) * radius, y + MathUtil.cos(seg * i) * radius, r, g, b, a,
					].iter(e->vertices.push(e));
				}
				
				indices.push(vertPos);
				for (i in 0...totalSegs) {
					indices.push(vertPos);
					indices.push(vertPos + i + 1);
				}
				indices.push(vertPos);
				indices.push(vertPos + 1);
				indices.push(vertPos + 1);
			}
			case FillColor.None:
		}
		
		var points = [];
		for (i in 0...totalSegs + 1) {
			points.push(x + MathUtil.sin(seg * i) * radius);
			points.push(y + MathUtil.cos(seg * i) * radius);
		}
		
		var line = new PolyLine(points);
		line.build(data, webglData);
	}
}