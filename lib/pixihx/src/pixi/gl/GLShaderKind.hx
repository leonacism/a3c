package pixi.gl;
import pixi.gl.GLConstants.Precision;

/**
 * @author leonaci
 */
enum GLShaderKind {
	Vertex(src:String, precision:Precision);
	Fragment(src:String, precision:Precision);
}