package util.js;
import js.Browser;
import js.html.CanvasElement;
import js.html.KeyboardEvent;

/**
 * ...
 * @author leo
 */
class KeyManagerJS {
	private var canvas:CanvasElement;
	
	public inline function new(canvas:CanvasElement) {
		this.canvas = canvas;
	}
	
	public inline function onKeyDown(handler:KeyboardEvent -> Void) {
		this.canvas.addEventListener('keydown', handler);
	}
	
	public inline function onKeyUp(handler:KeyboardEvent -> Void) {
		this.canvas.addEventListener('keyup', handler);
	}
}