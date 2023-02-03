package pixi.core.renderer.manager;
import pixi.core.display.DisplayObject;
import pixi.core.display.DisplayObjectContainer;
import pixi.core.graphics.Graphics;
import pixi.core.renderer.Renderer;

/**
 * ...
 * @author leonaci
 */
class MaskManager
{
	private var renderer:Renderer;
	
	private var scissor:Bool;
	private var scissorData:Graphics;
	private var scissorRenderTarget:RenderTarget;
	
	private var enableScissor:Bool;
	
	private var alphaMaskPool:Array<Dynamic>;//Array<AlphaMaskFilter>
	private var alphaMaskIndex:Int;
	
	public function new(renderer:Renderer) {
		this.renderer;
		
		scissor = false;
		scissorData = null;
		scissorRenderTarget = null;
		
		enableScissor = true;
		
		alphaMaskPool = [];
		alphaMaskIndex = 0;
	}
	
	public function pushMask(target:DisplayObject, maskData:DisplayObjectContainer):Void {
		
	}
	
	public function dispose():Void {
		renderer = null;
	}
}