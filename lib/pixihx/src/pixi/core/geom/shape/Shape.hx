package pixi.core.geom.shape;
import pixi.core.graphics.GraphicsData;
import pixi.core.graphics.WebGLGraphicsData;
import pixi.util.Constant;
import pixi.util.Constant.ShapeKind;

/**
 * @author leonaci
 */
interface Shape {
	var kind(default, null):ShapeKind;
	
	function contains(x:Float, y:Float):Bool;
	function getBounds():Rectangle;
	function build(data:GraphicsData, webglData:WebGLGraphicsData):Void;
}