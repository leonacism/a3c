package test;
import js.Browser;
import js.html.CanvasElement;
import js.html.Float32Array;
import js.html.Image;
import js.html.InputElement;
import js.html.Int16Array;
import js.html.webgl.GL;
import pixi.gl.GLBuffer;
import pixi.gl.GLConstants.DrawKind;
import pixi.gl.GLConstants.GeomKind;
import pixi.gl.GLConstants.Precision;
import pixi.gl.GLConstants.TextureDataType;
import pixi.gl.GLContext;
import pixi.gl.GLFrameBuffer;
import pixi.gl.GLShader;
import pixi.gl.GLShaderKind;
import pixi.gl.GLTexture;
import pixi.gl.GLVertexArrayObject;
import pixi.util.Current;

/**
 * ...
 * @author leonaci
 */
class PixiGLTest2
{
	private static var WIDTH:Int = 1000;
	private static var HEIGHT:Int = 1000;
	
	private static var VERTEX:String = "
		attribute vec3 position;
		attribute vec2 texCoord;
		
		varying vec2 vTexCoord;
		
		void main() {
			vTexCoord = texCoord;
			gl_Position = vec4(position, 1.0);
		}
	";
	
	private static var FRAGMENT:String = "
		precision mediump float;
		
		uniform sampler2D texture;
		
		varying vec2 vTexCoord;
		
		void main() {
			gl_FragColor = texture2D(texture, vTexCoord);
		}
	";
	
	private static var BLUR_VERTEX:String = "
		attribute vec3 position;
		
		void main(void){
			gl_Position = vec4(position, 1.0);
		}
	";
	
	private static var BLUR_FRAGMENT:String = "
		precision mediump float;
		
		uniform sampler2D texture;
		uniform bool      useBlur;
		
		void main(void){
			vec2 tFrag = vec2(1.0 / 1024.0);
			vec4 destColor = texture2D(texture, gl_FragCoord.st * tFrag);
			if(useBlur) {
				destColor *= 0.36;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-1.0,  1.0)) * tFrag) * 0.04;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 0.0,  1.0)) * tFrag) * 0.04;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 1.0,  1.0)) * tFrag) * 0.04;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-1.0,  0.0)) * tFrag) * 0.04;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 1.0,  0.0)) * tFrag) * 0.04;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-1.0, -1.0)) * tFrag) * 0.04;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 0.0, -1.0)) * tFrag) * 0.04;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 1.0, -1.0)) * tFrag) * 0.04;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-2.0,  2.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-1.0,  2.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 0.0,  2.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 1.0,  2.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 2.0,  2.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-2.0,  1.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 2.0,  1.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-2.0,  0.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 2.0,  0.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-2.0, -1.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 2.0, -1.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-2.0, -2.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2(-1.0, -2.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 0.0, -2.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 1.0, -2.0)) * tFrag) * 0.02;
				destColor += texture2D(texture, (gl_FragCoord.st + vec2( 2.0, -2.0)) * tFrag) * 0.02;
			}
			gl_FragColor  = destColor;
		}
	";

	static private var POSITION = [
		-1.0,  1.0,  0.0,
		 1.0,  1.0,  0.0,
		-1.0, -1.0,  0.0,
		 1.0, -1.0,  0.0,
	];
	
	static private var TEX_COORD = [
		0.0, 0.0,
		1.0, 0.0,
		0.0, 1.0,
		1.0, 1.0,
	];

	static private var INDEX = [
		0, 0, 1,
		2, 3, 3,
	];

	static public function main():Void {
		var gl:GL = GLContext.getContext(WIDTH, HEIGHT);
		gl.clearColor(0.5, 0.5, 0.5, 1.0);
		gl.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);
		
		/** main shader */
		
		var mainShader = new GLShader(gl,
			GLShaderKind.Vertex(VERTEX, Precision.High),
			GLShaderKind.Fragment(FRAGMENT, Precision.Medium)
		);
		
		var mainVao = new GLVertexArrayObject(gl);
		
		var mainPosition:GLBuffer = GLBuffer.createVertexBuffer(gl, new Float32Array(POSITION).buffer, DrawKind.StaticDraw);
		var mainTexCoord:GLBuffer = GLBuffer.createVertexBuffer(gl, new Float32Array(TEX_COORD).buffer, DrawKind.StaticDraw);
		
		var mainIbo:GLBuffer = GLBuffer.createIndexBuffer(gl, new Int16Array(INDEX).buffer, DrawKind.StaticDraw);
		mainVao.addIndex(mainIbo);
		
		/** blue shader */
		
		var blurShader = new GLShader(gl,
			GLShaderKind.Vertex(BLUR_VERTEX, Precision.High),
			GLShaderKind.Fragment(BLUR_FRAGMENT, Precision.Medium)
		);
		
		var blurVao = new GLVertexArrayObject(gl);
		
		var blurPosition:GLBuffer = GLBuffer.createVertexBuffer(gl, new Float32Array(POSITION).buffer, DrawKind.StaticDraw);
		
		var blurIbo:GLBuffer = GLBuffer.createIndexBuffer(gl, new Int16Array(INDEX).buffer, DrawKind.StaticDraw);
		blurVao.addIndex(blurIbo);
		
		/** texture */
		
		var img = new Image();
		img.crossOrigin = 'anonymous';
		img.src = 'test.png';
		img.onload = function() {
			var texture = GLTexture.fromSource(gl, img);
			texture.enableLinearScaling();
			texture.enableMipmap();
			
			var fbo = GLFrameBuffer.createRGBA(gl, 1024, 1024);
			
			var current = new Current();
			
			current.addFrameHandler(function() {
				fbo.bind();
				fbo.clear(0, 1, 0, 1);
				
				mainShader.bind();
				
				mainVao.addAttribute(mainPosition, mainShader.attributes['position'], TextureDataType.Float, true, 0, 0);
				mainVao.addAttribute(mainTexCoord, mainShader.attributes['texCoord'], TextureDataType.Float, true, 0, 0);
				
				texture.bind(0);
				mainShader.uniforms.set('texture', 0);
				
				mainVao.bind();
				mainVao.draw(GeomKind.TriangleStrip, INDEX.length, 0);
				
				fbo.unbind();
				
				blurShader.bind();
				
				blurVao.addAttribute(blurPosition, blurShader.attributes['position'], TextureDataType.Float, true, 0, 0);
				
				fbo.texture.bind(0);
				blurShader.uniforms.set('texture', 0);
				blurShader.uniforms.set('useBlur', false);
				
				blurVao.bind();
				blurVao.draw(GeomKind.TriangleStrip, INDEX.length, 0);
			});
			
			current.run();
		}
	}
	
}