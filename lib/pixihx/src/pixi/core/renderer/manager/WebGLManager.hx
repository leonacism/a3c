package pixi.core.renderer.manager;
import pixi.core.renderer.Renderer;
import pixi.util.PixiError;

/**
 * ...
 * @author leonaci
 */
class WebGLManager {
	private var renderer:Renderer;
	
	public function new(renderer:Renderer) {
		this.renderer = renderer;
		renderer.on(RendererEventKind.Context, onContextChange);
	}
	
	private function onContextChange():Void {}
	
	public function dispose() {
		renderer.off(RendererEventKind.Context, onContextChange);
		renderer = null;
	}
	
}