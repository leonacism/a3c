package pixi.core.shader;
import js.html.webgl.GL;
import pixi.gl.GLShader;
import pixi.gl.GLShaderKind;

/**
 * ...
 * @author leonaci
 */
class MultiTextureShader extends GLShader
{
	@:extern static inline private var VERTEX_SHADER:String = '
		precision highp float;
		attribute vec2 aVertexPosition;
		attribute vec2 aTextureCoord;
		attribute vec4 aColor;
		attribute float aTextureId;

		uniform mat3 projectionMatrix;

		varying vec2 vTextureCoord;
		varying vec4 vColor;
		varying float vTextureId;

		void main(void){
			gl_Position = vec4((projectionMatrix * vec3(aVertexPosition, 1.0)).xy, 0.0, 1.0);

			vTextureCoord = aTextureCoord;
			vTextureId = aTextureId;
			vColor = aColor;
		}
	';
	
	@:extern static inline private var FRAGMENT_SHADER:String = '
		precision mediump float;
		
		varying vec2 vTextureCoord;
		varying vec4 vColor;
		varying float vTextureId;
		uniform sampler2D uSamplers[%count%];
		
		void main(void){
			vec4 color;
			float textureId = floor(vTextureId + 0.5);
			%forloop%
			gl_FragColor = color * vColor;
		}
	';

	public function new(gl:GL, maxTextures:Int) {
		var fragment = FRAGMENT_SHADER;
		fragment = ~/%count%/gi.replace(fragment, '${maxTextures}');
		fragment = ~/%forloop%/gi.replace(fragment, generateSampleSrc(maxTextures));
		
		super(
			gl,
			GLShaderKind.Vertex(VERTEX_SHADER, Config.PRECISION_VERTEX),
			GLShaderKind.Fragment(fragment, Config.PRECISION_FRAGMENT)
		);
		
		this.bind();
		this.uniforms.set('uSamplers', [for (i in 0...maxTextures) i]);
	}
	
	private function generateSampleSrc(maxTextures:Int):String {
		var src = '';
		
		for (i in 0...maxTextures) {
			src += switch(i) {
				case 0: '
					if (textureId == ${i}.0)
				';
				case i if(0 < i && i < maxTextures): '
					else if (textureId == ${i}.0)
				';
				default: throw '!?';
			}
			
			src += '{
				color = texture2D(uSamplers[${i}], vTextureCoord);
			}';
		}
		
		return src;
	}
}