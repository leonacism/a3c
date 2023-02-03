package pixi.core.sprites;
import haxe.ds.Option;
import haxe.ds.Vector;
import js.lib.Float32Array;
import js.lib.Int16Array;
import js.lib.Uint16Array;
import js.lib.Uint32Array;
import js.html.webgl.GL;
import pixi.core.display.DisplayObject;
import pixi.core.renderer.DisplayObjectRenderer;
import pixi.core.renderer.Renderer;
import pixi.core.renderer.RendererEventKind;
import pixi.core.renderer.manager.WebGLManager;
import pixi.core.shader.MultiTextureShader;
import pixi.core.texture.Texture;
import pixi.gl.GLConstants.Precision;
import pixi.gl.GLShaderKind;
import pixi.util.Color;
import pixi.gl.GLBuffer;
import pixi.gl.GLConstants.DrawKind;
import pixi.gl.GLConstants.GeomKind;
import pixi.gl.GLConstants.TextureDataType;
import pixi.gl.GLShader;
import pixi.gl.GLVertexArrayObject;
import pixi.util.BlendMode;
import pixi.util.MathUtil;

/**
 * ...
 * @author leonaci
 */
class SpriteRenderer implements DisplayObjectRenderer
{
	private var gl(get, never):GL;
	inline function get_gl():GL return renderer.gl;
	
	public var CONTEXT_UID(get, never):Int;
	inline function get_CONTEXT_UID():Int return renderer.CONTEXT_UID;
	
	private var MAX_TEXTURES:Int;
	
	private var renderer:Renderer;
	private var shader:GLShader;
	
	private var vaos:Array<GLVertexArrayObject>;
	private var vao:GLVertexArrayObject;
	private var VAO_MAX:Int;
	private var vertexCount:Int;
	
	private var vbos:Array<GLBuffer>;
	
	private var ibo:GLBuffer;
	private var indices:Uint16Array;
	
	private var currentIndex:Int;
	private var sprites:Array<Sprite>;
	private var groups:Array<TextureGroup>;
	
	private var buffers:Array<Buffer>;
	
	private var boundTextures:Vector<Texture>;
	
	static private var TICK:Int = 0;
	static private var TEXTURE_TICK:Int = 0;
	
	public function new(renderer:Renderer) {
		this.renderer = renderer;
		renderer.on(RendererEventKind.Context, onContext);
		
		vaos = [];
		VAO_MAX = 2;
		vertexCount = 0;
		
		vbos = [];
		
		indices = new Uint16Array(6 * Config.SPRITE_BATCH_SIZE);
		for (i in 0...Config.SPRITE_BATCH_SIZE) {
			indices[6 * i + 0] = 4 * i + 0;
			indices[6 * i + 1] = 4 * i + 1;
			indices[6 * i + 2] = 4 * i + 2;
			indices[6 * i + 3] = 4 * i + 0;
			indices[6 * i + 4] = 4 * i + 2;
			indices[6 * i + 5] = 4 * i + 3;
		}
		
		currentIndex = 0;
		sprites = [];
		groups = [];
		for (i in 0...Config.SPRITE_BATCH_SIZE) {
			groups[i] = {
				textures: [],
				ids: [],
				size: 0,
				start: 0,
				blendMode: BlendMode.Normal,
			};
		}
		
		buffers = [for(i in 0...MathUtil.log2(MathUtil.nextPow2(Config.SPRITE_BATCH_SIZE))) new Buffer(4 * 20 * Std.int(MathUtil.pow(2, i)))];
		
		renderer.on(RendererEventKind.Prerender, onPrerender);
	}
	
	private function onPrerender():Void {
		vertexCount = 0;
	}
	
	private function onContext():Void {
		MAX_TEXTURES = gl.getParameter(GL.MAX_TEXTURE_IMAGE_UNITS);
		
		shader = new MultiTextureShader(gl, MAX_TEXTURES);
		ibo = GLBuffer.createIndexBuffer(gl, indices.buffer, DrawKind.StaticDraw);
		
		renderer.unbindVAO();
		
		var attrs = shader.attributes;
		
		for (i in 0...VAO_MAX) {
			var vbo = vbos[i] = GLBuffer.createVertexBuffer(gl, null, DrawKind.StreamDraw);
			
			var vao = new GLVertexArrayObject(gl);
			vao.addIndex(ibo);
			vao.addAttribute(vbo, attrs['aVertexPosition'], TextureDataType.Float, false, 4 * 5, 0);
			vao.addAttribute(vbo, attrs['aTextureCoord'], TextureDataType.UnsignedShort, true, 4 * 5, 4 * 2);
			vao.addAttribute(vbo, attrs['aColor'], TextureDataType.UnsignedByte, true, 4 * 5, 4 * 3);
			if (attrs.exists('aTextureId')) vao.addAttribute(vbo, attrs['aTextureId'], TextureDataType.Float, false, 4 * 5, 4 * 4);
			
			vaos[i] = vao;
		}
		
		vao = vaos[0];
		
		boundTextures = new Vector(MAX_TEXTURES);
	}
	
	public inline function start():Void {
		renderer.bindShader(shader);
		
		if (Config.CAN_UPLOAD_SAME_BUFFER) {
			renderer.bindVAO(vaos[vertexCount]);
			vbos[vertexCount].bind();
		}
	}
	
	public inline function stop():Void {
		flush();
	}
	
	public inline function flush():Void {
		if (currentIndex == 0) return;
		
		var buffer:Buffer = buffers[MathUtil.log2(MathUtil.nextPow2(currentIndex))];
		var rendererBoundTextures = renderer.boundTextures;
		
		var currentTexture:Texture = null;
		var textureCount:Int = 0;
		
		var blendMode:BlendMode = null;
		
		var groupCount = 0;
		var currentGroup:TextureGroup = null;
		
		TICK++;
		
		for (i in 0...MAX_TEXTURES) {
			boundTextures[i] = rendererBoundTextures[i];
			boundTextures[i].virtualBoundId = i;
		}
		
		for (i in 0...currentIndex) {
			var sprite = sprites[i];
			var nextTexture = sprite.texture;
			
			var spriteBlendMode = premultipliedBlendModes(sprite);
			
			if (blendMode != spriteBlendMode) {
				blendMode = spriteBlendMode;
				
				currentTexture = null;
				textureCount = MAX_TEXTURES;
				
				TICK++;
			}
			
			if (currentTexture != nextTexture) {
				currentTexture = nextTexture;
				
				if(nextTexture.enabled != TICK) {
					if (textureCount == MAX_TEXTURES) {
						TICK++;
						
						textureCount = 0;
						
						currentGroup = groups[groupCount++];
						currentGroup.size = i - currentGroup.start;
						currentGroup.start = i;
						currentGroup.blendMode = blendMode;
					}
				}
				
				renderer.textureManager.GC.touch(nextTexture);
				
				if (nextTexture.virtualBoundId == -1) {
					for (i in 0...MAX_TEXTURES) {
						var textureIndex = (i + TEXTURE_TICK) % MAX_TEXTURES;
						
						var boundTexture = boundTextures[textureIndex];
						if (boundTexture.enabled != TICK) {
							TEXTURE_TICK++;
							
							boundTexture.virtualBoundId = -1;
							
							nextTexture.virtualBoundId = textureIndex;
							
							boundTextures[textureIndex] = nextTexture;
							
							break;
						}
					}
				}
				
				nextTexture.enabled = TICK;
				
				currentGroup.ids[textureCount] = nextTexture.virtualBoundId;
				currentGroup.textures[textureCount++] = nextTexture;
			}
			
			var vertices = new Float32Array(sprite.vertices);
			
			var uvs = sprite.texture.uvs.uvsUint32;
			
			var alpha = MathUtil.min(sprite.globalAlpha, 1.0);
			var tint = pixi.util.Color.Hex(sprite.tint.hex, sprite.tint.a * alpha);
			var argb:UInt = nextTexture.premultipliedAlpha? premultipliedTint(tint) : tint;
			var float32View = buffer.float32View;
			var uint32View = buffer.uint32View;
			
			float32View[20 * i     ] = vertices[0];
			float32View[20 * i +  1] = vertices[1];
			 uint32View[20 * i +  2] = uvs[0];
			 uint32View[20 * i +  3] = argb;
			 uint32View[20 * i +  4] = nextTexture.virtualBoundId;
			
			float32View[20 * i +  5] = vertices[2];
			float32View[20 * i +  6] = vertices[3];
			 uint32View[20 * i +  7] = uvs[1];
			 uint32View[20 * i +  8] = argb;
			 uint32View[20 * i +  9] = nextTexture.virtualBoundId;
			
			float32View[20 * i + 10] = vertices[4];
			float32View[20 * i + 11] = vertices[5];
			 uint32View[20 * i + 12] = uvs[2];
			 uint32View[20 * i + 13] = argb;
			 uint32View[20 * i + 14] = nextTexture.virtualBoundId;
			
			float32View[20 * i + 15] = vertices[6];
			float32View[20 * i + 16] = vertices[7];
			 uint32View[20 * i + 17] = uvs[3];
			 uint32View[20 * i + 18] = argb;
			 uint32View[20 * i + 19] = nextTexture.virtualBoundId;
		}
		
		currentGroup.size = currentIndex - currentGroup.start;
		
		if (!Config.CAN_UPLOAD_SAME_BUFFER) {
			if (vertexCount >= VAO_MAX) {
				VAO_MAX++;
				
				var attrs = shader.attributes;
				var vbo = vbos[vertexCount] = GLBuffer.createVertexBuffer(gl, null, DrawKind.StreamDraw);
				var vao = new GLVertexArrayObject(gl);
				vao.addIndex(ibo);
				vao.addAttribute(vbo, attrs['aVertexPosition'], TextureDataType.Float, false, 4 * 5, 0);
				vao.addAttribute(vbo, attrs['aTextureCoord'], TextureDataType.UnsignedShort, true, 4 * 5, 4 * 2);
				vao.addAttribute(vbo, attrs['aColor'], TextureDataType.UnsignedByte, true, 4 * 5, 4 * 3);
				if (attrs.exists('aTextureId')) vao.addAttribute(vbo, attrs['aTextureId'], TextureDataType.Float, false, 4 * 5, 4 * 4);
				
				vaos[vertexCount] = vao;
			}
			
			renderer.bindVAO(vaos[vertexCount]);
			vbos[vertexCount].upload(buffer.vertices, 0, false);
			
			vertexCount++;
		}
		else vbos[vertexCount].upload(buffer.vertices, 0, true);
		
		for (i in 0...MAX_TEXTURES) rendererBoundTextures[i].virtualBoundId = -1;
		
		for (group in groups) {
			for (i in 0...group.textures.length) {
				if (rendererBoundTextures[group.ids[i]] != group.textures[i]) {
					renderer.bindTexture(group.textures[i], group.ids[i], true);
				}
			}
			
			renderer.state.setBlendMode(group.blendMode);
			
			renderer.activeVAO.draw(GeomKind.Triangles, 6 * group.size, 6 * 2 * group.start);
		}
		
		currentIndex = 0;
	}
	
	private inline function premultipliedBlendModes(sprite:Sprite):BlendMode {
		return switch [sprite.texture.premultipliedAlpha, sprite.blendMode] {
			case [true, BlendMode.NormalNpm]: BlendMode.Normal;
			case [true, BlendMode.AddNpm]: BlendMode.Add;
			case [true, BlendMode.ScreenNpm]: BlendMode.Screen;
			case [false, BlendMode.Normal]: BlendMode.NormalNpm;
			case [false, BlendMode.Add]: BlendMode.AddNpm;
			case [false, BlendMode.Screen]: BlendMode.ScreenNpm;
			case [_, mode]: mode;
		}
	}
	
	private function premultipliedTint(tint:Color):UInt {
		var R:UInt = tint.R;
		var G:UInt = tint.G;
		var B:UInt = tint.B;
		var a:Float = tint.a;
		
		R = Std.int(R * a);
		G = Std.int(G * a);
		B = Std.int(B * a);
		
		return ((tint.A << 24) | (R << 16) | (G << 8) | B);
	}
	
	public function render(object:DisplayObject):Void {
		var sprite:Sprite = cast object;
		if (currentIndex >= Config.SPRITE_BATCH_SIZE) flush();
		
		if (sprite.texture.uvs == null) return;
		
		sprites[currentIndex++] = sprite;
	}
	
	public function dispose():Void {
		renderer.off(RendererEventKind.Context, onContext);
		renderer.off(RendererEventKind.Prerender, onPrerender);
		
		for (i in 0...VAO_MAX) {
			if (vaos[i] != null) vaos[i].dispose();
			if (vbos[i] != null) vbos[i].dispose();
		}
		
		if (ibo != null) ibo.dispose();
		
		if (shader != null) shader.dispose();
		
		renderer = null;
		shader = null;
		
		vaos = null;
		vbos = null;
		
		ibo = null;
		indices = null;
		
		sprites = null;
		
		groups = null;
		
		for (buffer in buffers) buffer.dispose();
		buffers = null;
		
		boundTextures = null;
	}
}