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
class Ellipse implements Shape
{
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	
	public var kind(default, null):ShapeKind;
	
	public function new(?x:Float=0, ?y:Float=0, ?width:Float=0, ?height:Float=0) {
		this.x = x;
		this.y = y;
		this.width  = width;
		this.height = height;
		
		kind = ShapeKind.Ellipse;
	}
	
	public function clone():Ellipse {
		return new Ellipse(x, y, width, height);
	}
	
	public function copy(ellip:Ellipse):Void {
		x = ellip.x;
		y = ellip.y;
		width = ellip.width;
		height = ellip.height;
	}
	
	public function contains(x:Float, y:Float):Bool {
		if (width <= 0 || height <= 0) return false;
		
		var dx = (x - this.x) / width;
		var dy = (y - this.y) / height;
		return dx*dx + dy*dy <= 1;
	}
	
	public function getBounds():Rectangle {
		return new Rectangle(x - width, y - height, 2 * width, 2 * height);
	}
	
	public function build(data:GraphicsData, webglData:WebGLGraphicsData):Void {
		var totalSegs = MathUtil.floor(15 * MathUtil.sqrt(width + height));
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
						x + MathUtil.sin(seg * i) * width, y + MathUtil.cos(seg * i) * height, r, g, b, a,
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
			points.push(x + MathUtil.sin(seg * i) * width);
			points.push(y + MathUtil.cos(seg * i) * height);
		}
		
		var line = new PolyLine(points);
		line.build(data, webglData);
	}
}