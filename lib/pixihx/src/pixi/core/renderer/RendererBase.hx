package pixi.core.renderer;
import js.html.CanvasElement;
import pixi.core.display.DisplayObject;
import pixi.core.geom.shape.Rectangle;
import pixi.core.util.event.EventListener;
import pixi.util.BlendMode;
import pixi.util.Color;

/**
 * ...
 * @author leonaci
 */
class RendererBase<Role:EnumValue> extends EventListener<Role> {
	private var kind:RenderKind;
	private var options:RenderOptions;
	
	public var width(get, never):Float;
	inline function get_width():Float return view.width;
	
	public var height(get, never):Float;
	inline function get_height():Float return view.height;
	
	public var view(default, null):CanvasElement;
	
	public var backgroundColor:Color;
	
	private var screen:Rectangle;
	private var blendMode:BlendMode;
	
	public var renderingToScreen(default, null):Bool;
	
	public var lastObjectRendered(default, null):DisplayObject;
	
	public function new(kind:RenderKind, width:Float, height:Float, ?options:RenderOptions) {
		super();
		
		this.kind = kind;
		
		if (options == null) options = {};
		this.options = options;
		
		view = options.view;
		backgroundColor = pixi.util.Color.Hex(options.backgroundColor, 1.0);
		screen = new Rectangle(0, 0, width, height);
		blendMode = null;
		
		renderingToScreen = true;
	}
	
	public function generateTexture(displayObject:DisplayObject, scaleMode:Float, resolution:Float):Dynamic {
		var boundsRect:Rectangle = displayObject.getLocalBoundsRect();
		
		return null;
	}
	
	public function resize(width:Float, height:Float):Void {
		screen.width = width;
		screen.height = height;
		
		view.width = Std.int(width * options.resolution);
		view.height = Std.int(height * options.resolution);
		
		if (options.autoResize) {
			view.style.position = 'absolute';
			view.style.margin = 'auto';
			view.style.width  = '${width}px';
			view.style.height = '${height}px';
			view.style.top = '0px';
			view.style.left = '0px';
			view.style.bottom = '0px';
			view.style.right = '0px';
		}
	}
	
	public function dispose():Void {
		view.parentNode.removeChild(view);
		
		kind = null;
		options = null;
		screen = null;
		view = null;
		backgroundColor = null;
		blendMode = null;
	}
}