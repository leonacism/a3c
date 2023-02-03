package pixi.core.renderer;
import pixi.core.display.DisplayObject;

/**
 * ...
 * @author leonaci
 */
interface DisplayObjectRenderer {
	/**
	 * starts the renderer and sets the shader
	 */
	function start():Void;
	
	/**
	 * stops the renderer.
	 */
	function stop():Void;
	
	/**
	 * Stub method for rendering content and emptying the current batch.
	 */
	function flush():Void;
	
	/**
	 * renders an object.
	 * @param	object - the rendered object 
	 */
	function render(object:DisplayObject):Void;
	
	/**
	 * dispose the renderer.
	 */
	function dispose():Void;
}