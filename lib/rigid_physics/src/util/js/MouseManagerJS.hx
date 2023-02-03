package util.js;

import js.Browser;
import js.html.MouseEvent;
import js.html.CanvasElement;

/**
 * ...
 * @author leo
 */
class MouseManagerJS {
	private var canvas:CanvasElement;
	
	public inline function new(canvas:CanvasElement) {
		this.canvas = canvas;
	}
	
	public inline function onMouseMove(handler:MouseEvent -> Void) {
		canvas.addEventListener('mousemove', handler);
	}
	
	public inline function mouseDown(handler:MouseEvent -> Void) {
		canvas.addEventListener('mousedown', handler);
	}
	
	public inline function mouseUp(handler:MouseEvent -> Void) {
		canvas.addEventListener('mouseup', handler);
	}
	
	public inline function eventHandler(type:String, handler:MouseEvent -> Void) {
		canvas.addEventListener(type, handler);
	}
}