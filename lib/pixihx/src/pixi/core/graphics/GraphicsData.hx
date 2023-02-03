package pixi.core.graphics;
import pixi.core.geom.shape.Rectangle;
import pixi.core.geom.shape.Shape;
import pixi.util.Color;
import pixi.util.Constant.ShapeKind;

/**
 * ...
 * @author leonaci
 */
@:structInit class GraphicsData
{
	public var lineWidth:Float;
	public var nativeLines:Bool;
	public var lineColor:Color;
	
	public var fillColor:FillColor;
	
	public var holes:Array<Rectangle>;
	
	public var shape:Shape;
	
	public var kind(get, never):ShapeKind;
	inline function get_kind():ShapeKind return shape.kind;
	
	inline function new(
		lineWidth,
		nativeLines,
		lineColor,
		fillColor,
		shape
	) 
	{
		this.lineWidth = lineWidth;
		this.nativeLines = nativeLines;
		this.lineColor = lineColor;
		this.fillColor = fillColor;
		this.shape = shape;
	}
	
	public inline function clone():GraphicsData {
		return new GraphicsData(
			lineWidth,
			nativeLines,
			lineColor,
			fillColor,
			shape
		);
	}
	
	public inline function dispose():Void {
		lineColor = null;
		fillColor = null;
		holes = null;
		shape = null;
	}
}