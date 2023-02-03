package pixi.core.graphics;
import haxe.ds.Option;
import pixi.core.display.DisplayObjectContainer;
import pixi.core.geom.Bounds;
import pixi.core.geom.point.Point;
import pixi.core.geom.shape.Circle;
import pixi.core.geom.shape.Ellipse;
import pixi.core.geom.shape.Rectangle;
import pixi.core.geom.shape.RoundedRectangle;
import pixi.core.geom.shape.Shape;
import pixi.core.renderer.Renderer;
import pixi.util.Color;
import pixi.util.BlendMode;
import pixi.util.Constant.ShapeKind;
import pixi.util.MathUtil;

typedef PolygonShape = pixi.core.geom.shape.Polygon;

/**
 * ...
 * @author leonaci
 */
@:allow(pixi.core.graphics.GraphicsRenderer)
class Graphics extends DisplayObjectContainer
{
	public var blendMode:BlendMode;
	public var tint:Color;
	
	public var lineWidth:Float;
	public var nativeLines:Bool;
	public var lineColor:Color;
	public var lineAlpha:Float;
	
	public var fillColor:FillColor;
	
	public var boundsPadding:Float;
	
	
	private var currentPath:Option<GraphicsData>;
	private var graphicsData:Array<GraphicsData>;
	private var webglDataContexts:Array<WebGLGraphicsDataset>;
	
	private var localBounds:Bounds;
	
	private var dataDirty:Bool;
	private var clearDirty:Bool;
	
	public function new() {
		super();
		
		blendMode = BlendMode.Normal;
		tint = pixi.util.Color.Hex(0xFFFFFF, 1);
		
		lineWidth = 0;
		nativeLines = false;
		lineColor = pixi.util.Color.Hex(0x000000, 1);
		
		fillColor = FillColor.None;
		
		boundsPadding = 0;
		
		
		currentPath = Option.None;
		graphicsData = [];
		webglDataContexts = [];
		
		localBounds = new Bounds();
		
		dataDirty = false;
		clearDirty = false;
	}
	
	public inline function drawShape(shape:Shape):Void {
		switch(currentPath) {
			case Option.Some(currentPath):
				switch(currentPath.shape.kind) {
					case ShapeKind.Polygon:
						var poly:PolygonShape = Std.downcast(currentPath.shape,PolygonShape);
						if (poly.points.length <= 2) graphicsData.pop();
					case _:
				}
			case Option.None:
		}
		
		currentPath = Option.None;
		
		var data:GraphicsData = {
			lineWidth: lineWidth,
			nativeLines: nativeLines,
			lineColor: lineColor,
			fillColor: fillColor,
			shape: shape,
		};
		
		graphicsData.push(data);
		
		switch(shape.kind) {
			case ShapeKind.Polygon:
				currentPath = Option.Some(data);
				
			case _:
		}
		
		dataDirty = true;
	}
	
	public function lineStyle(lineWidth:Float, lineColor:Color):Void {
		this.lineWidth = lineWidth;
		this.lineColor = lineColor;
		
		switch(currentPath) {
			case Option.Some(currentPath):
				switch(currentPath.shape.kind) {
					case ShapeKind.Polygon:
						var poly:PolygonShape = cast currentPath.shape;
						poly = PolygonShape.fromArray(poly.points.copy().slice(-2));
						drawShape(poly);
						
					case _:
						currentPath.lineWidth = lineWidth;
						currentPath.lineColor = lineColor;
				}
				
			case Option.None:
		}
	}
	
	public function moveTo(x:Float, y:Float):Graphics {
		var poly = PolygonShape.fromArray([x, y]);
		drawShape(poly);
		return this;
	}
	
	public function lineTo(x:Float, y:Float):Void {
		switch(currentPath) {
			case Option.Some(currentPath):
				switch(currentPath.kind) {
					case ShapeKind.Polygon:
						var poly:PolygonShape = Std.downcast(currentPath.shape,PolygonShape);
						poly.points.push(x);
						poly.points.push(y);
						
					case _:
				}
				
			case Option.None:
		}
	}
	
	public function beginFill(?color:Color) {
		fillColor = color!=null? FillColor.Fill(color) : FillColor.None;
		
		switch(currentPath) {
			case Option.Some(currentPath):
				switch(currentPath.kind) {
					case ShapeKind.Polygon:
						var poly:PolygonShape = Std.downcast(currentPath.shape,PolygonShape);
						if (poly.points.length <= 2) currentPath.fillColor = fillColor;
					case _:
				}
			case Option.None:
		}
	}
	
	public function endFill():Void {
		fillColor = FillColor.None;
	}
	
	public function closePath():Void {
		switch(currentPath) {
			case Option.Some(currentPath):
				switch(currentPath.kind) {
					case ShapeKind.Polygon:
						var poly:PolygonShape = Std.downcast(currentPath.shape, PolygonShape);
						poly.close();
						
					case _:
				}
			case Option.None:
		}
	}
	
	public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
		drawShape(new Rectangle(x, y, width, height));
	}
	
	public function drawRoundedRect(x:Float, y:Float, width:Float, height:Float, radius:Float):Void {
		drawShape(new RoundedRectangle(x, y, width, height, radius));
	}
	
	public function drawCircle(x:Float, y:Float, radius:Float):Void {
		drawShape(new Circle(x, y, radius));
	}
	
	public function drawEllipse(x:Float, y:Float, width:Float, height:Float):Void {
		drawShape(new Ellipse(x, y, width, height));
	}
	
	public function drawPolygon(points:Array<Point>):Void {
		drawShape(new PolygonShape(points));
	}
	
	public function clear():Void {
		lineWidth = 0;
		fillColor = FillColor.None;
		
		boundsDirty = true;
		dataDirty = true;
		clearDirty = true;
		
		graphicsData = [];
		currentPath = Option.None;
	}
	
	override private function renderContainer(renderer:Renderer):Void {
		renderer.setDisplayObjectRenderer(renderer.graphics);
		renderer.graphics.render(this);
	}
	
	private inline function renderSpriteRect(renderer:Renderer):Void {
		// not implemented.
	}
	
	private inline function isFastRect() {
		return graphicsData.length == 1 && Type.enumEq(graphicsData[0].shape.kind, ShapeKind.Rectangle) && graphicsData[0].lineWidth == 0;
	}
	
	override private function calculateDisplayObjectBounds():Void {
		if (boundsDirty) {
			boundsDirty = false;
			updateLocalBoundsRect();
		}
		
		bounds.addFrame(transform, localBounds.minX, localBounds.minY, localBounds.maxX, localBounds.maxY);
	}
	
	private inline function updateLocalBoundsRect():Void {
		var minX = MathUtil.POSITIVE_INFINITY;
		var minY = MathUtil.POSITIVE_INFINITY;
		var maxX = MathUtil.NEGATIVE_INFINITY;
		var maxY = MathUtil.NEGATIVE_INFINITY;
		
		for (data in graphicsData) {
			var rect:Rectangle = data.shape.getBounds();
			var x = rect.x - lineWidth / 2;
			var y = rect.y - lineWidth / 2;
			var w = rect.width + lineWidth;
			var h = rect.height + lineWidth;
			
			minX = x   < minX? x   : minX;
			minY = y   < minY? y   : minY;
			maxX = maxX < x+w? x+w : maxX;
			maxY = maxY < y+h? y+h : maxY;
		}
		
		localBounds.minX = minX - boundsPadding;
		localBounds.minX = minX - boundsPadding;
		localBounds.maxX = maxX + boundsPadding;
		localBounds.maxY = maxY + boundsPadding;
	}
	
	override public function dispose():Void {
		super.dispose();
		
		for (data in graphicsData) data.dispose();
		
		graphicsData = null;
		webglDataContexts = null;
		currentPath = null;
		localBounds = null;
	}
}