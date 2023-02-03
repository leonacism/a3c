package pixi.core.texture;
import pixi.core.display.DisplayObject;
import pixi.core.display.DisplayObjectContainer;
import pixi.core.texture.Texture;
import pixi.core.texture.TextureManager;

/**
 * ...
 * @author leonaci
 */
class TextureGarbageCollector
{
	private var textureManager:TextureManager;
	
	private var count:Int;
	private var checkCount:Int;

	public function new(textureManager:TextureManager) {
		this.textureManager = textureManager;
		
		count = 0;
		checkCount = 0;
	}
	
	public inline function update():Void {
		count++;
		checkCount++;
		
		if (checkCount > Config.GC_MAX_CHECK_COUNT) {
			checkCount = 0;
			run();
		}
	}
	
	private inline function run():Void {
		var managedTextures = textureManager.managedTextures;
		
		for (texture in managedTextures) {
			if (count - texture.touched > Config.GC_MAX_IDLE) {
				textureManager.disposeTexture(texture, true);
				managedTextures.remove(texture);
			}
		}
	}
	
	public inline function touch(texture:Texture):Void {
		texture.touched = count;
	}
	
	public function unload(displayObject:DisplayObject):Void {
		/*
		if (displayObject.texture != null) {
			textureManager.disposeTexture(displayObject.texture, true);
		}
		*/
		
		if (Std.is(displayObject, DisplayObjectContainer)) {
			var container:DisplayObjectContainer = Std.downcast(displayObject, DisplayObjectContainer);
			for (child in container) unload(child);
		}
	}
}