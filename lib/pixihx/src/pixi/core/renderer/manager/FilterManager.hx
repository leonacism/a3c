package pixi.core.renderer.manager;
import pixi.core.renderer.Renderer;

/**
 * ...
 * @author leonaci
 */
class FilterManager {
	private var renderer:Renderer;

	public function new(renderer:Renderer) {
		this.renderer = renderer;
		renderer.on(RendererEventKind.Context, onContext);
	}
	
	private function onContext():Void {
		
	}
	
	public function dispose():Void {
		renderer.off(RendererEventKind.Context, onContext);
		renderer = null;
	}
}