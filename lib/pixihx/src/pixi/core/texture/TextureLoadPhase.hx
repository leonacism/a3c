package pixi.core.texture;
import js.html.ImageElement;

/**
 * @author leonaci
 */
enum TextureLoadPhase {
	Unload;
	InLoading(src:ImageElement);
	Completed(src:ImageElement, ext:String);
}