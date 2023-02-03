package pixi.core.graphics;
import js.lib.ArrayBuffer;
import js.lib.Float32Array;
import js.lib.Int16Array;
import js.html.webgl.GL;
import pixi.gl.GLAttributeState;
import pixi.gl.GLBuffer;
import pixi.gl.GLConstants.TextureDataType;
import pixi.gl.GLShader;
import pixi.gl.GLVertexArrayObject;

/**
 * ...
 * @author leonaci
 */
class WebGLGraphicsData
{
	private var gl:GL;
	
	private var shader:GLShader;
	
	public var vertices(default, null):Array<Float>;
	private var vbo:GLBuffer;
	
	public var indices(default, null):Array<Int>;
	private var ibo:GLBuffer;
	
	public var vao(default, null):GLVertexArrayObject;
	
	private var dirty:Bool;
	
	public function new(gl:GL, shader:GLShader) {
		this.gl = gl;
		
		this.shader = shader;
		
		vertices = [];
		vbo = GLBuffer.createVertexBuffer(gl);
		
		indices = [];
		ibo = GLBuffer.createIndexBuffer(gl);
		
		vao = new GLVertexArrayObject(gl);
		vao.addAttribute(vbo, shader.attributes['aVertexPosition'], TextureDataType.Float, false, 4 * 6,     0);
		vao.addAttribute(vbo, shader.attributes[         'aColor'], TextureDataType.Float, false, 4 * 6, 2 * 4);
		vao.addIndex(ibo);
		
		dirty = true;
	}
	
	public function reset():Void {
		vertices = [];
		indices = [];
		
		dirty = true;
	}
	
	public function upload():Void {
		if (!dirty) return;
		
		dirty = false;
		
		var buffer = new ArrayBuffer(6);
		vbo.upload(new Float32Array(vertices).buffer);
		ibo.upload(new Int16Array(indices).buffer);
	}
	
	public function dispose():Void {
		gl = null;
		shader = null;
		vertices = null;
		indices = null;
		vao = null;
	}
}