package pixi.core.shader;
import js.html.webgl.GL;
import pixi.gl.GLShader;
import pixi.gl.GLShaderKind;

/**
 * ...
 * @author leonaci
 */
class PrimitiveShader extends GLShader {
	@:extern static inline private var VERTEX_SHADER:String = '
		attribute vec2 aVertexPosition;
		attribute vec4 aColor;
		
		uniform mat3 translationMatrix;
		uniform mat3 projectionMatrix;
		
		uniform float alpha;
		uniform vec3 tint;
		
		varying vec4 vColor;
		
		void main(void) {
			gl_Position = vec4((projectionMatrix * translationMatrix * vec3(aVertexPosition, 1.0)).xy, 0.0, 1.0);
			vColor = aColor * vec4(tint * alpha, alpha);
		}
	';
	
	@:extern static inline private var FRAGMENT_SHADER:String = '
		precision mediump float;
		
		varying vec4 vColor;
		
		void main(void) {
			gl_FragColor = vColor;
		}
	';
	
	
	public function new(gl:GL) {
		super(
			gl,
			GLShaderKind.Vertex(VERTEX_SHADER, Config.PRECISION_VERTEX),
			GLShaderKind.Fragment(FRAGMENT_SHADER, Config.PRECISION_FRAGMENT)
		);
	}
	
}
