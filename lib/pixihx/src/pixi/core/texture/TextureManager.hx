package pixi.core.texture;
import haxe.ds.List;
import haxe.ds.Option;
import js.html.webgl.GL;
import pixi.core.renderer.RenderTarget;
import pixi.core.renderer.Renderer;
import pixi.core.texture.RenderTexture;
import pixi.core.texture.Texture;
import pixi.core.texture.TextureLoadPhase;
import pixi.gl.GLConstants.WrapKind;
import pixi.gl.GLTexture;
import pixi.util.Constant.ScaleMode;
import pixi.util.PixiError;

/**
 * ...
 * @author leonaci
 */
class TextureManager
{
	private var gl:GL;
	private var renderer:Renderer;
	
	public var GC(default, null):TextureGarbageCollector;
	
	@:allow(pixi.core.texture.TextureGarbageCollector)
	private var managedTextures:List<Texture>;
	
	public function new(renderer:Renderer) {
		gl = renderer.gl;
		this.renderer = renderer;
		
		GC = new TextureGarbageCollector(this);
		
		managedTextures = new List();
	}
	
	public function updateTexture(texture:Texture, ?location:Int):GLTexture {
		switch(texture.phase) {
			case TextureLoadPhase.Completed(src, _):
				var boundTextures = renderer.boundTextures;
				
				if(location==null) {
					location = 0;
					for (i in 0...boundTextures.length) {
						if (boundTextures[i] == texture) {
							location = i;
							break;
						}
					}
				}
				
				boundTextures[location] = texture;
				
				gl.activeTexture(GL.TEXTURE0 + location);
				
				var glTexture:GLTexture = null;
				
				if (texture.glTextures.exists(renderer.CONTEXT_UID)) {
					if (Std.is(texture, RenderTexture)) {
						var renderTexture:RenderTexture = Std.downcast(texture, RenderTexture);
						renderTexture.glRenderTargets[renderer.CONTEXT_UID].resize(texture.width, texture.height);
					}
					else glTexture.uploadSource(src);
				}
				else {
					if (Std.is(texture, RenderTexture)) {
						var renderTexture:RenderTexture = Std.downcast(texture, RenderTexture);
						var renderTarget = new RenderTarget(gl, renderTexture.width, renderTexture.height, renderTexture.scaleMode, renderTexture.resolution);
						renderTarget.resize(renderTexture.width, renderTexture.height);
						renderTexture.glRenderTargets[renderer.CONTEXT_UID] = renderTarget;
						glTexture = renderTarget.texture;
					}
					else {
						glTexture = new GLTexture(gl);
						glTexture.bind(location);
						glTexture.uploadSource(src);
					}
					
					texture.glTextures.set(renderer.CONTEXT_UID, glTexture);
					texture.on(TextureEventKind.Update, updateTexture.bind(texture));
					texture.on(TextureEventKind.Dispose, disposeTexture.bind(texture));
					
					managedTextures.add(texture);
					
					if (texture.isPowOfTwo) {
						if (texture.mipmap) glTexture.enableMipmap();
						
						switch(texture.wrapMode) {
							case WrapKind.Repeat: glTexture.enableWrapRepeat();
							case WrapKind.ClampToEdge: glTexture.enableWrapClamp();
							case WrapKind.MirroredRepeat: glTexture.enableWrapMirrorRepeat();
						}
					}
					else {
						glTexture.enableWrapClamp();
					}
					
					switch(texture.scaleMode) {
						case ScaleMode.Linear: glTexture.enableLinearScaling();
						case ScaleMode.Nearest: glTexture.enableNearestScaling();
					}
				}
				
				return glTexture;
				
			case _: throw new PixiError('the texture not loaded yet. complete to load the texture.');
		}
	}
	
	public function disposeTexture(texture:Texture, ?skipRemove:Bool = false):Void {
		switch(texture.phase) {
			case TextureLoadPhase.Completed(src, _):
				if (texture.glTextures.exists(renderer.CONTEXT_UID)) {
					renderer.unbindTexture(texture);
					texture.glTextures.get(renderer.CONTEXT_UID).dispose();
					texture.off(TextureEventKind.Update, updateTexture.bind(texture));
					texture.off(TextureEventKind.Dispose, disposeTexture.bind(texture));
					
					texture.glTextures.remove(renderer.CONTEXT_UID);
					
					if (!skipRemove) managedTextures.remove(texture);
				}
				
			case _:
		}
	}
	
	public function removeAll():Void {
		for (texture in managedTextures) {
			texture.glTextures.remove(renderer.CONTEXT_UID);
		}
	}
	
	public function dispose():Void {
		for (texture in managedTextures) disposeTexture(texture, true);
		
		gl = null;
		renderer = null;
		managedTextures = null;
	}
}