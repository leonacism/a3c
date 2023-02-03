package pixi.core.renderer;
import haxe.ds.Option;
import haxe.ds.Vector;
import js.html.webgl.ContextAttributes;
import js.html.webgl.ContextEvent;
import js.html.webgl.Extension;
import js.html.webgl.GL;
import pixi.core.display.DisplayObject;
import pixi.core.geom.Affine;
import pixi.core.graphics.GraphicsRenderer;
import pixi.core.renderer.DisplayObjectRenderer;
import pixi.core.renderer.manager.FilterManager;
import pixi.core.renderer.manager.MaskManager;
import pixi.core.renderer.manager.StencilManager;
import pixi.core.sprites.SpriteRenderer;
import pixi.core.texture.RenderTexture;
import pixi.core.texture.Texture;
import pixi.core.texture.TextureManager;
import pixi.gl.GLContext;
import pixi.gl.GLContextOptions;
import pixi.gl.GLShader;
import pixi.gl.GLTexture;
import pixi.gl.GLVertexArrayObject;
import pixi.util.BlendMode;
import pixi.util.Color;

/**
 * ...
 * @author leonaci
 */
@:allow(
	pixi.core.renderer.manager.FilterManager,
	pixi.core.renderer.manager.MaskManager,
	pixi.core.renderer.manager.StencilManager,
	pixi.core.renderer.DisplayObjectRenderer,
	pixi.core.texture.TextureManager
)
class Renderer extends RendererBase<RendererEventKind> {
	static private var uid:Int = 0;
	
	public var CONTEXT_UID(default, null):Int;
	
	private var gl:GL;
	
	private var state:WebGLState;
	
	private var activeShader:Option<GLShader>;
	private var activeVAO:GLVertexArrayObject;
	private var activeRenderTarget:RenderTarget;
	
	private var currentRenderer:Option<DisplayObjectRenderer>;
	private var rootRenderTarget:RenderTarget;
	
	public var textureManager(default, null):TextureManager;
	public var boundTextures(default, null):Vector<Texture>;
	private var dummyTextures:Vector<Texture>;
	
	public var stencilManager(default, null):StencilManager;
	
	
	public var graphics(default, null):GraphicsRenderer;
	public var sprite(default, null):SpriteRenderer;
	
	public function new(width:Float, height:Float, ?options:RenderOptions) {
		super(RenderKind.WebGL, width, height, options);
		
		view.addEventListener('webglcontextlost', contextLostHandler);
		view.addEventListener('webglcontextrestored', contextRestoredHandler);
		
		CONTEXT_UID = uid++;
		
		stencilManager = new StencilManager(this);
		
		graphics = new GraphicsRenderer(this);
		sprite = new SpriteRenderer(this);
		
		var contextOptions:ContextAttributes = {
			alpha: options.transparent,
			antialias: options.antialias,
			premultipliedAlpha: options.transparent,
			stencil: true,
			preserveDrawingBuffer: options.preserveDrawingBuffer,
		};
		gl = GLContext.getContext(view.width, view.height, contextOptions);
		
		state = new WebGLState(gl);
		
		init();
	}
	
	private function init():Void {
		if (gl.isContextLost() && gl.getExtension(Extension.WEBGL_lose_context)!=null) {
			(gl.getExtension(Extension.WEBGL_lose_context)).restoreContext();
		}
		
		state.resetToDefault();
		
		activeShader = Option.None;
		
		rootRenderTarget = new RenderTarget(gl, 0, 0, options.resolution, true);
		rootRenderTarget.backgroundColor = backgroundColor;
		bindRenderTarget(rootRenderTarget);
		
		currentRenderer = Option.None;
		
		textureManager = new TextureManager(this);
		
		var maxTextures:Int = gl.getParameter(GL.MAX_TEXTURE_IMAGE_UNITS);
		boundTextures = new Vector(maxTextures);
		dummyTextures = new Vector(maxTextures);
		for (i in 0...maxTextures) {
			dummyTextures[i] = Texture.fromImage('');
			dummyTextures[i].glTextures[CONTEXT_UID] = GLTexture.fromData(gl, null, 1, 1);
			boundTextures[i] = dummyTextures[i];
			bindTexture(dummyTextures[i], i, true);
		}
		
		invoke(RendererEventKind.Context);
		
		resize(screen.width, screen.height);
	}
	
	public function render(displayObject:DisplayObject, ?renderTexture:RenderTexture, ?transform:Affine, ?skipTransformUpdate:Bool=false) {
		renderingToScreen = (renderTexture == null);
		
		invoke(RendererEventKind.Prerender);
		
		if (gl == null || gl.isContextLost()) return;
		
		if (renderTexture == null) lastObjectRendered = displayObject;
		
		if (!skipTransformUpdate) displayObject.updateLocalTransform();
		
		bindRenderTexture(renderTexture, transform);
		
		switch(currentRenderer) {
			case Option.Some(currentRenderer): currentRenderer.start();
			case Option.None:
		}
		
		if(options.clearBeforeRender) activeRenderTarget.clear();
		displayObject.render(this);
		
		switch(currentRenderer) {
			case Option.Some(currentRenderer): currentRenderer.flush();
			case Option.None:
		}
		
		textureManager.GC.update();
		
		invoke(RendererEventKind.Postrender);
	}
	
	public inline function setDisplayObjectRenderer(?displayObjectRenderer:DisplayObjectRenderer):Void {
		switch(currentRenderer) {
			case Option.Some(previousRenderer) if (previousRenderer == displayObjectRenderer):
			case Option.Some(previousRenderer):
				if (previousRenderer == displayObjectRenderer) return;
				previousRenderer.stop();
				
				currentRenderer = if (displayObjectRenderer != null) {
					displayObjectRenderer.start();
					Option.Some(displayObjectRenderer);
				}
				else Option.None;
				
			case Option.None:
				currentRenderer = if (displayObjectRenderer != null) {
					displayObjectRenderer.start();
					Option.Some(displayObjectRenderer);
				}
				else Option.None;
		}
	}
	
	public function flush():Void {
		switch(currentRenderer) {
			case Option.Some(previousRenderer):
				previousRenderer.stop();
				currentRenderer = Option.None;
				
			case Option.None:
		}
	}
	
	override public function resize(screenWidth:Float, screenHeight:Float):Void {
		super.resize(screenWidth, screenHeight);
		
		rootRenderTarget.resize(screenWidth, screenHeight);
		
		if (activeRenderTarget == rootRenderTarget) {
			rootRenderTarget.activate();
			
			switch(activeShader) {
				case Option.Some(activeShader):
					activeShader.uniforms.set('projectionMatrix', rootRenderTarget.projectionMatrix.toArray(true));
				case Option.None:
			}
		}
	}
	
	public inline function setBlendMode(blendMode:BlendMode):Void {
		state.setBlendMode(blendMode);
	}
	
	public inline function clear(color:Color):Void {
		activeRenderTarget.clear(color);
	}
	
	public inline function setTransform(matrix:Affine):Void {
		activeRenderTarget.transform = Option.Some(matrix);
	}
	
	public function bindShader(shader:GLShader, ?autoProject:Bool=true):Void {
		switch(activeShader) {
			case Option.Some(previousShader) if (previousShader == shader):
			case _:
				activeShader = Option.Some(shader);
				shader.bind();
				
				if(autoProject) shader.uniforms.set('projectionMatrix', activeRenderTarget.projectionMatrix.toArray(true));
		}
	}
	
	public function bindRenderTarget(renderTarget:RenderTarget):Void {
		if (renderTarget == activeRenderTarget) return;
		
		activeRenderTarget = renderTarget;
		activeRenderTarget.activate();
		
		switch(activeShader) {
			case Option.Some(activeShader):
				activeShader.uniforms.set('projectionMatrix', renderTarget.projectionMatrix.toArray(true));
			case Option.None:
		}
	}
	
	public function bindRenderTexture(?renderTexture:RenderTexture, ?transform:Affine):Void {
		var renderTarget:RenderTarget = null;
		
		if(renderTexture != null) {
			if (renderTexture.glRenderTargets[CONTEXT_UID] != null) textureManager.updateTexture(renderTexture);
			
			unbindTexture(renderTexture);
			
			renderTarget = renderTexture.glRenderTargets[CONTEXT_UID];
			renderTarget.setFrame(renderTexture.frame, renderTexture.frame);
		}
		else renderTarget = rootRenderTarget;
		
		renderTarget.transform = transform!=null? Option.Some(transform) : Option.None;
		bindRenderTarget(renderTarget);
	}
	
	public inline function clearRenderTexture(renderTexture:RenderTexture, color:Color):Void {
		var renderTarget = renderTexture.glRenderTargets[CONTEXT_UID];
		renderTarget.clear(color);
	}
	
	public function bindTexture(texture:Texture, location:Int, ?forceLocation:Bool = false):Int {
		textureManager.GC.touch(texture);
		
		if (!forceLocation) {
			for (i in 0...boundTextures.length) if (boundTextures[i] == texture) return i;
		}
		
		
		if (texture.glTextures.exists(CONTEXT_UID)) {
			var glTexture = texture.glTextures.get(CONTEXT_UID);
			boundTextures[location] = texture;
			glTexture.bind(location);
		}
		else textureManager.updateTexture(texture, location);
		
		return location;
	}
	
	public inline function unbindTexture(texture:Texture):Void {
		for (i in 0...boundTextures.length) {
			boundTextures[i] = dummyTextures[i];
			
			dummyTextures[i].glTextures[CONTEXT_UID].bind(i);
		}
	}
	
	public inline function bindVAO(vao:GLVertexArrayObject):Void {
		if (activeVAO == vao) return;
		
		activeVAO = vao;
		activeVAO.bind();
	}
	
	public inline function unbindVAO():Void {
		activeVAO = null;
	}
	
	public function reset():Void {
		setDisplayObjectRenderer(null);
		activeShader = Option.None;
		activeRenderTarget = rootRenderTarget;
		rootRenderTarget.activate();
		state.resetToDefault();
	}
	
	private function contextLostHandler(event:ContextEvent):Void {
		event.preventDefault();
	}
	
	private function contextRestoredHandler():Void {
		textureManager.removeAll();
		init();
	}
	
	override public function dispose():Void {
		super.dispose();
		
		uid = 0;
		
		view.removeEventListener('webglcontextlost', contextLostHandler);
		view.removeEventListener('webglcontextrestored', contextRestoredHandler);
		
		if (gl.getExtension('WEBGL_lose_context')!=null) {
			gl.getExtension(Extension.WEBGL_lose_context).loseContext();
		}
		
		gl.useProgram(null);
		
		gl = null;
		
		activeShader = null;
		activeRenderTarget = null;
		activeVAO = null;
		
		rootRenderTarget = null;
		
		currentRenderer = null;
		
		textureManager.dispose();
		textureManager = null;
		boundTextures = null;
		
		stencilManager.dispose();
		stencilManager = null;
		
		graphics.dispose();
		graphics = null;
	}
}