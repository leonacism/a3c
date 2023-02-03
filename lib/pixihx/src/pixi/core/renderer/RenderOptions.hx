package pixi.core.renderer;
import js.Browser;
import js.html.CanvasElement;

/**
 * @author leonaci
 */
@:structInit class RenderOptions {
	public var view(default, null):CanvasElement;
	public var transparent(default, null):Bool;
	public var autoResize(default, null):Bool;
	public var antialias(default, null):Bool;
	public var forceFXAA(default, null):Bool;
	public var resolution(default, null):Float;
	public var clearBeforeRender(default, null):Bool;
	public var preserveDrawingBuffer(default, null):Bool;
	public var roundPixels(default, null):Bool;
	public var backgroundColor(default, null):Int;
	
	inline function new(
		?view = null,
		?transparent = false,
		?autoResize = false,
		?antialias = false,
		?forceFXAA = false,
		?resolution,
		?clearBeforeRender = true,
		?preserveDrawingBuffer = false,
		?roundPixels = false,
		?backgroundColor = 0x000000
	) {
		this.view = view!=null? view : cast Browser.document.createCanvasElement();
		this.transparent = transparent;
		this.autoResize = autoResize;
		this.antialias = antialias;
		this.forceFXAA = forceFXAA;
		this.resolution = resolution!=null? resolution : Config.RESOLUTION;
		this.clearBeforeRender = clearBeforeRender;
		this.preserveDrawingBuffer = preserveDrawingBuffer;
		this.roundPixels = roundPixels;
		this.backgroundColor = backgroundColor;
	}
}