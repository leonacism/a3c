package pixi.core.graphics;
import js.html.webgl.GL;
import pixi.core.display.DisplayObject;
import pixi.core.graphics.WebGLGraphicsDataset;
import pixi.core.renderer.DisplayObjectRenderer;
import pixi.core.renderer.Renderer;
import pixi.core.renderer.RendererEventKind;
import pixi.core.renderer.manager.WebGLManager;
import pixi.core.shader.PrimitiveShader;
import pixi.gl.GLConstants.GeomKind;

/**
 * ...
 * @author leonaci
 */
class GraphicsRenderer implements DisplayObjectRenderer
{
	private var renderer:Renderer;
	private var shader:PrimitiveShader;
	
	private var gl(get, never):GL;
	inline function get_gl():GL return renderer.gl;
	
	public var CONTEXT_UID(get, never):Int;
	inline function get_CONTEXT_UID():Int return renderer.CONTEXT_UID;
	
	private var webglDataPool:Array<WebGLGraphicsData>;
	
	public function new(renderer:Renderer) {
		this.renderer = renderer;
		renderer.on(RendererEventKind.Context, onContext);
		
		webglDataPool = [];
	}
	
	private function onContext():Void {
		shader = new PrimitiveShader(gl);
	}
	
	public inline function start():Void {
		renderer.bindShader(shader);
	}
	
	public inline function stop():Void {
		flush();
	}
	
	public inline function flush():Void {
		
	}
	
	public function render(object:DisplayObject):Void {
		var graphics:Graphics = Std.downcast(object, Graphics);
		
		var webglDataset:WebGLGraphicsDataset = graphics.webglDataContexts[CONTEXT_UID];
		
		if (webglDataset == null || graphics.dataDirty) {
			webglDataset = updateGraphics(graphics);
		}
		
		renderer.state.setBlendMode(graphics.blendMode);
		
		for (webgldata in webglDataset.data) {
			var vao = webgldata.vao;
			var len = webgldata.indices.length;
			
			shader.uniforms.set('translationMatrix', graphics.global.toArray(true));
			shader.uniforms.set('alpha', graphics.globalAlpha);
			shader.uniforms.set('tint', [graphics.tint.r, graphics.tint.g, graphics.tint.b]);
			
			renderer.bindVAO(vao);
			vao.draw(GeomKind.TriangleStrip, len, 0);
		}
	}
	
	private function updateGraphics(graphics:Graphics):WebGLGraphicsDataset {
		var webglDataset:WebGLGraphicsDataset = graphics.webglDataContexts[CONTEXT_UID];
		if (webglDataset == null) webglDataset = graphics.webglDataContexts[CONTEXT_UID] = {data:[], lastIndex:0};
		
		graphics.dataDirty = false;
		/* When `graphics` cleared, we put its webgl data into the object pool with no attention to the UID. */
		if (graphics.clearDirty) {
			graphics.clearDirty = false;
			for(webglData in webglDataset.data) webglDataPool.push(webglData);
			webglDataset.data = [];
			webglDataset.lastIndex = 0;
		}
		
		for (i in webglDataset.lastIndex...graphics.graphicsData.length) {
			var data = graphics.graphicsData[i];
			
			/* If no data array exists, pick it up from the pool. */
			var webglData:WebGLGraphicsData = getWebglData(webglDataset);
			data.shape.build(data, webglData);
			
			webglDataset.lastIndex++;
		}
		
		for (webglData in webglDataset.data) webglData.upload();
		
		return webglDataset;
	}
	
	private function getWebglData(webglDataset:WebGLGraphicsDataset):WebGLGraphicsData {
		var webglData:WebGLGraphicsData = webglDataset.data[webglDataset.data.length - 1];
		
		if (webglData == null || webglData.vertices.length > 320000) {
			webglData = webglDataPool.length != 0? webglDataPool.pop() : new WebGLGraphicsData(gl, shader);
			webglData.reset();
			webglDataset.data.push(webglData);
		}
		
		return webglData;
		
	}
	
	public function dispose():Void {
		renderer.off(RendererEventKind.Context, onContext);
		for (data in webglDataPool) data.dispose();
		
		renderer = null;
		webglDataPool = null;
	}
}