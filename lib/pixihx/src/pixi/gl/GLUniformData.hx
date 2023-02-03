package pixi.gl;
import js.html.webgl.UniformLocation;
import pixi.gl.GLConstants.PrimitiveType;

/**
 * @author leonaci
 */
typedef GLUniformData = {
	var size:Int;
	var location:UniformLocation;
	var type:PrimitiveType;
	var value:Dynamic;
}