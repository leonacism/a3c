package pixi.core.renderer.manager;
import js.html.webgl.GL;
import pixi.core.graphics.Graphics;
import pixi.core.renderer.Renderer;

/**
 * ...
 * @author leonaci
 */
class StencilManager {
	private var renderer:Renderer;
	
	private var stencilMaskStack:Array<Graphics>;
	
	public function new(renderer:Renderer) {
		this.renderer = renderer;
	}
	
	public function setMaskStack(stencilMaskStack:Array<Graphics>):Void {
		this.stencilMaskStack = stencilMaskStack;
		
		if (stencilMaskStack.length == 0) renderer.gl.disable(GL.STENCIL_TEST);
		else renderer.gl.enable(GL.STENCIL_TEST);
	}
	
	public function push(graphics:Graphics):Void {
		renderer.setDisplayObjectRenderer(renderer.graphics);
		
		renderer.activeRenderTarget.attachStencilBuffer();
		
		var gl = renderer.gl;
		
		if (stencilMaskStack.length == 0) {
			gl.enable(GL.STENCIL_TEST);
			gl.clear(GL.STENCIL_BUFFER_BIT);
			gl.stencilFunc(GL.ALWAYS, 1, 1);
		}
		
		stencilMaskStack.push(graphics);
		
		gl.colorMask(false, false, false, false);
		gl.stencilOp(GL.KEEP, GL.KEEP, GL.INCR);
		
		renderer.graphics.render(graphics);
		
		gl.colorMask(true, true, true, true);
		gl.stencilFunc(GL.NOTEQUAL, 0, stencilMaskStack.length);
		gl.stencilOp(GL.KEEP, GL.KEEP, GL.KEEP);
	}
	
	public function popStencil(graphics:Graphics):Void {
		renderer.setDisplayObjectRenderer(renderer.graphics);
		
		var gl:GL = renderer.gl;
		
		if (stencilMaskStack.length == 0) {
			gl.disable(GL.STENCIL_TEST);
		}
		else {
			gl.colorMask(false, false, false, false);
			gl.stencilOp(GL.KEEP, GL.KEEP, GL.DECR);
			
			renderer.graphics.render(graphics);
			
			gl.colorMask(true, true, true, true);
			gl.stencilFunc(GL.NOTEQUAL, 0, stencilMaskStack.length);
			gl.stencilOp(GL.KEEP, GL.KEEP, GL.KEEP);
		}
	}
	
	public function dispose():Void {
		stencilMaskStack = null;
	}
}