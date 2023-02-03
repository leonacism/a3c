package pixi.core.texture;
import haxe.ds.Option;
import pixi.core.geom.shape.Rectangle;
import pixi.core.sprites.SpriteRenderer;
import pixi.core.texture.TextureGarbageCollector;
import pixi.core.util.event.EventListener;
import pixi.gl.GLConstants.WrapKind;
import pixi.gl.GLTexture;
import pixi.util.Constant.ScaleMode;
import pixi.util.MathUtil;
import pixi.util.PixiError;

/**
 * ...
 * @author leonaci
 */
class Texture extends EventListener<TextureEventKind>
{
	static public var textureCache(default, null):Map<String, Texture> = new Map();
	
	public var phase(get, never):TextureLoadPhase;
	inline function get_phase():TextureLoadPhase return baseTexture.phase;
	
	public var resolution(get, never):Float;
	inline function get_resolution():Float return baseTexture.resolution;
	
	public var isPowOfTwo(get, never):Bool;
	inline function get_isPowOfTwo():Bool return MathUtil.isPowOf2(Std.int(baseTexture.realWidth)) && MathUtil.isPowOf2(Std.int(baseTexture.realHeight));
	
	private var baseTexture:TextureBase;
	
	public var mipmap:Bool;
	public var scaleMode:ScaleMode;
	public var wrapMode:WrapKind;
	
	public var premultipliedAlpha:Bool;
	
	public var width(get, never):Float;
	inline function get_width():Float return orig.width;
	
	public var height(get, never):Float;
	inline function get_height():Float return orig.height;
	
	public var frame(default, set):Rectangle;
	 function set_frame(frame:Rectangle):Rectangle {
		this.frame = frame;
		
		if (frame.x +frame.width > baseTexture.width || frame.y + frame.height > baseTexture.height) {
			throw new PixiError('frame does not fit inside the base texture dimensions.');
		}
		
		if (Type.enumEq(trim, Option.None)) orig = frame;
		
		if (valid) updateUvs();
		else on(TextureEventKind.Update, updateUvs);
		
		return frame;
	}
	
	public var orig(default, null):Rectangle;
	public var trim(default, null):Option<Rectangle>;
	
	private var valid(get, never):Bool;
	inline function get_valid():Bool {
		return switch(phase) {
			case TextureLoadPhase.Completed(_, _) if (frame != null && frame.width != null && frame.height != null): true;
			case _: false;
		}
	}
	public var uvs(default, null):TextureUvs;
	
	private var updateDirty:Bool;
	
	public var glTextures(default, null):Map<Int, GLTexture>;
	
	private var textureCacheIDs:Array<String>;
	
	@:allow(pixi.core.texture.TextureGarbageCollector)
	private var touched:Int;
	
	@:allow(pixi.core.sprites.SpriteRenderer)
	private var enabled:Int;
	@:allow(pixi.core.sprites.SpriteRenderer)
	private var virtualBoundId:Int;
	
	private function new(baseTexture:TextureBase, ?frame:Rectangle, ?orig:Rectangle, ?trim:Rectangle) {
		super();
		
		this.baseTexture = baseTexture;
		
		scaleMode = Config.SCALE_MODE;
		wrapMode = Config.WRAP_MODE;
		mipmap = Config.MIPMAP_TEXTURES;
		
		premultipliedAlpha = true;
		
		this.frame = frame != null? frame : new Rectangle(0, 0, 1, 1);
		this.orig = orig != null? orig : this.frame;
		this.trim = trim != null? Option.Some(trim) : Option.None;
		
		switch(baseTexture.phase) {
			case TextureLoadPhase.Completed(src, ext):
				if (frame == null) {
					frame = new Rectangle(0, 0, baseTexture.width, baseTexture.height);
					baseTexture.on(TextureBaseEventKind.Update, onBaseTextureUpdated);
				}
				
			case _:
				baseTexture.once(TextureBaseEventKind.Loaded, onBaseTextureLoaded);
		}
		
		updateDirty = false;
		
		glTextures = new Map();
		
		textureCacheIDs = [];
		
		touched = 0;
		
		enabled = 0;
		virtualBoundId = -1;
		
		on(TextureEventKind.Update, update);
	}
	
	private function update():Void {
		updateUvs();
	}
	
	private function updateUvs():Void {
		updateDirty = true;
		
		if (uvs == null) uvs = new TextureUvs();
		
		var baseFrame:Rectangle = new Rectangle(0, 0, baseTexture.width, baseTexture.height);
		uvs.set(frame, baseFrame, false);
	}
	
	private function onBaseTextureLoaded():Void {
		updateDirty = true;
		
		if (frame == null) {
			frame = new Rectangle(0, 0, baseTexture.width, baseTexture.height);
		}
		
		baseTexture.on(TextureBaseEventKind.Update, onBaseTextureUpdated);
		onBaseTextureUpdated();
	}
	
	private function onBaseTextureUpdated():Void {
		updateDirty = true;
		
		frame.width  = baseTexture.width;
		frame.height = baseTexture.height;
		
		invoke(TextureEventKind.Update);
	}
	
	static public function fromImage(url:String):Texture {
		var texture:Texture = null;
		
		if (textureCache.exists(url)) texture = textureCache.get(url);
		else {
			texture = new Texture(TextureBase.fromImage(url));
			addToCache(texture, url);
		}
		
		return texture;
	}
	
	static public function addToCache(texture:Texture, id:String):Void {
		if (texture.textureCacheIDs.indexOf(id) == -1) {
			texture.textureCacheIDs.push(id);
		}
		
		textureCache.set(id, texture);
	}
	
	static public function removeFromCache(texture:Texture):Void {
		for (id in texture.textureCacheIDs) textureCache.remove(id);
		texture.textureCacheIDs = [];
	}
	
	public function dispose():Void {
		if (textureCache.get(baseTexture.imageUrl)!=null) {
			removeFromCache(cast TextureBase.textureBaseCache.get(baseTexture.imageUrl));
			
			baseTexture.dispose();
		}
		
		baseTexture.off(TextureBaseEventKind.Loaded, onBaseTextureLoaded);
		baseTexture.off(TextureBaseEventKind.Update, onBaseTextureUpdated);
		
		baseTexture = null;
		
		frame = null;
		orig = null;
		trim = null;
		
		uvs = null;
		
		removeFromCache(this);
	}
}