package test;
import js.html.webgl.GL;
import js.lib.Float32Array;
import js.lib.Int16Array;
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
class PixiGLTest {
	private static var WIDTH:Int = 1136;
	private static var HEIGHT:Int = 640;
	
	private static var VERTEX_SHADER:String = "
		attribute vec3 position;
		attribute vec3 color;
		
		varying vec3 vColor;
		
		void main(void) {
			vColor = color;
			gl_Position = vec4(position, 1.0);
		}
	";
	
	private static var FRAGMENT_SHADER:String = "
		precision mediump float;
		
		uniform vec3  resolution;
		uniform float globalTime;
		uniform float timeDelta;
		uniform int   frame;
		
		varying vec3 vColor;
		
		struct Ray{
			vec3 origin;
			vec3 direction;
		};
		
		struct Sphere{
			float radius;
			vec3  position;
			vec3  color;
		};
		
		struct Intersection{
			bool hit;
			vec3 hitPoint;
			vec3 normal;
			vec3 color;
		};
		
		Intersection intersectSphere(Ray R, Sphere S){
			Intersection i;
			vec3  a = R.origin - S.position;
			float b = dot(a, R.direction);
			float c = dot(a, a) - (S.radius * S.radius);
			float d = b * b - c;
			if(d > 0.0){
				float t = -b - sqrt(d);
				if (t > 0.0){
					i.hit = true;
					i.hitPoint = R.origin + R.direction * t;
					i.normal = normalize(i.hitPoint - S.position);
					float d = clamp(dot(normalize(vec3(1.0)), i.normal), 0.1, 1.0);
					i.color = S.color * d;
					return i;
				}
			}
			i.hit = false;
			i.hitPoint = vec3(0.0);
			i.normal = vec3(0.0);
			i.color = vec3(0.0);
			return i;
		}
		
		void main(void) {
			vec2 p = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);
			
			Ray ray;
			ray.origin = vec3(0.0, 0.0, 5.0);
			ray.direction = normalize(vec3(p.x, p.y, -1.0));
			
			Sphere sphere;
			sphere.radius = 1.0;
			sphere.position = 1.5*vec3(cos(globalTime), sin(globalTime), cos(globalTime * 3.0));
			sphere.color = vec3(1.0);
			
			Intersection i = intersectSphere(ray, sphere);
			gl_FragColor = vec4(vColor * i.color, 1.0);
		}
	";
	
	/* x, y, z , r, g, b, */
	static private var vertex = [
		  1.0, 1.0, 0.0, 1.0, 0.0, 0.0,
		 -1.0, 1.0, 0.0, 0.0, 1.0, 0.0,
		  1.0,-1.0, 0.0, 1.0, 0.0, 1.0,
		 -1.0,-1.0, 0.0, 0.0, 0.0, 1.0,
	];
	static private var index = [
		  0, 0, 1,
		  2, 3, 3,
	];
	
	static public function main():Void {
		var gl:GL = GLContext.getContext(WIDTH, HEIGHT);
		gl.clearColor(0.5, 0.5, 0.5, 1.0);
		gl.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);
		
		var shader = new GLShader(gl,
			GLShaderKind.Vertex(VERTEX_SHADER, Precision.High),
			GLShaderKind.Fragment(FRAGMENT_SHADER, Precision.Medium)
		);
		shader.bind();
		
		var vbo:GLBuffer = GLBuffer.createVertexBuffer(gl, DrawKind.StaticDraw);
		var ibo = GLBuffer.createIndexBuffer(gl, new Int16Array(index).buffer, DrawKind.StaticDraw);
		
		var vao = new GLVertexArrayObject(gl);
		vao.addAttribute(vbo, shader.attributes['position'], TextureDataType.Float, true, 4 * 6,     0);
		vao.addAttribute(vbo, shader.attributes[   'color'], TextureDataType.Float, true, 4 * 6, 4 * 3);
		vao.addIndex(ibo);
		
		var current = new Current();
		
		current.addFrameHandler(function() {
			vbo.upload(new Float32Array(vertex).buffer);
			ibo.upload(new Int16Array(index).buffer);
			
			shader.uniforms.set('resolution', [WIDTH, HEIGHT, 0]);
			shader.uniforms.set('globalTime', current.currentTime);
			
			vao.bind();
			vao.draw(GeomKind.TriangleStrip, index.length, 0);
		});
		
		current.run();
	}
}