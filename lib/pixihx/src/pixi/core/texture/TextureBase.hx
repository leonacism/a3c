package pixi.core.texture;
import js.html.Image;
import js.html.ImageElement;
import pixi.core.util.event.EventListener;
import pixi.util.Constant;
import pixi.util.MathUtil;

/**
 * ...
 * @author leonaci
 */
class TextureBase extends EventListener<TextureBaseEventKind> {
	static public var textureBaseCache(default, null):Map<String, TextureBase> = new Map();
	
	public var width(get,never):Float;
	inline function get_width():Float return realWidth / resolution;
	
	public var height(get,never):Float;
	inline function get_height():Float return realHeight / resolution;
	
	public var phase(default, null):TextureLoadPhase;
	
	public var realWidth:Float;
	public var realHeight:Float;
	
	public var imageUrl(default, null):String;
	
	public var resolution(default, null):Float;
	
	private var textureCacheIDs:Array<String>;
	
	private function new(source:ImageElement, ?resolution:Float) {
		super();
		
		phase = TextureLoadPhase.Unload;
		
		this.resolution = resolution!=null? resolution : Config.RESOLUTION;
		
		textureCacheIDs = [];
		
		loadSource(source);
	}
	
	public function update():Void {
		switch(phase) {
			case TextureLoadPhase.Completed(src, _):
				switch(phase) {
					case TextureLoadPhase.Completed(src, _):
						realWidth  = src.naturalWidth;
						realHeight = src.naturalHeight;
					case _:
				}
				
				invoke(TextureBaseEventKind.Update);
			case _:
		}
	}
	
	public function loadSource(source:ImageElement):Void {
		switch(phase) {
			case _ if (source.complete && source.width != null && source.height != null):
				phase = TextureLoadPhase.Completed(source, getImageType(source));
				update();
				
			case TextureLoadPhase.Unload | TextureLoadPhase.Completed(_, _):
				phase = TextureLoadPhase.InLoading(source);
				source.onload = onLoadHandler.bind(source);
				source.onerror = onErrorHandler.bind(source);
				
			case TextureLoadPhase.InLoading(prevSource):
				prevSource.onload = null;
				prevSource.onerror = null;
				phase = TextureLoadPhase.Unload;
				loadSource(source);
		}
	}
	
	private function onLoadHandler(source:ImageElement):Void {
		source.onload = null;
		source.onerror = null;
		phase = TextureLoadPhase.Completed(source, getImageType(source));
		update();
		
		invoke(TextureBaseEventKind.Loaded);
	}
	
	private function onErrorHandler(source:ImageElement):Void {
		source.onload = null;
		source.onerror = null;
		phase = TextureLoadPhase.Unload;
		
		invoke(TextureBaseEventKind.Error);
	}
	
	private function getImageType(source:ImageElement):String {
		if (imageUrl == null) return null;
		
		var dataUri = {
			media:    Constant.DATA_URI.replace(imageUrl, '$1').toLowerCase(),
			ext:      Constant.DATA_URI.replace(imageUrl, '$2').toLowerCase(),
			encoding: Constant.DATA_URI.replace(imageUrl, '$3').toLowerCase(),
			data:     Constant.DATA_URI.replace(imageUrl, '$4').toLowerCase(),
		};
		
		return switch(dataUri.media) {
			case 'image':
				var firstExt = dataUri.ext.split('+')[0];
				getUrlFileExt('.${firstExt}');
				
			case _:
				getUrlFileExt(imageUrl);
		}
	}
	
	private inline function getUrlFileExt(ext:String):String {
		return Constant.URL_FILE_EXT.replace(ext, '$1').toLowerCase();
	}
	
	static public function fromImage(url:String):TextureBase {
		var image = new Image();
		image.src = url;
		
		var textureBase = new TextureBase(image, getResolutionOfUrl(url));
		textureBase.imageUrl = url;
		
		return textureBase;
	}
	
	static private inline function getResolutionOfUrl(url:String):Float {
		var resolution = Std.parseFloat(Constant.RETINA_PREFIX.replace(url, '$1'));
		return MathUtil.isNaN(resolution)? 1 : resolution; 
	}
	
	static public function addToCache(textureBase:TextureBase, id:String):Void {
		if (textureBase.textureCacheIDs.indexOf(id) ==-1) {
			textureBase.textureCacheIDs.push(id);
		}
		
		textureBaseCache.set(id, textureBase);
	}
	
	static public function removeFromCache(textureBase:TextureBase):Void {
		for (id in textureBase.textureCacheIDs) textureBaseCache.remove(id);
		textureBase.textureCacheIDs = [];
	}
	
	public function dispose():Void {
		if (imageUrl != null) {
			
			imageUrl = null;
		}
		
		phase = null;
		
		TextureBase.removeFromCache(this);
		
		textureCacheIDs = null;
	}
}