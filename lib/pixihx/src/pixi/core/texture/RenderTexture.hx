package pixi.core.texture;
import pixi.core.renderer.RenderTarget;
import pixi.core.geom.shape.Rectangle;

/**
 * ...
 * @author leonaci
 */
class RenderTexture extends Texture
{
	public var glRenderTargets(get, never):Array<RenderTarget>;
	inline function get_glRenderTargets():Array<RenderTarget> return cast (baseTexture, RenderTextureBase).glRenderTargets;
	
	private function new(baseRenderTexture:RenderTextureBase, ?frame:Rectangle) {
		super(baseRenderTexture, frame);
		
		updateUvs();
	}
	
	public function resize(width:Float, height:Float, ?doNotResizeBase:Bool=true):Void {
		frame.width  = orig.width  = width;
		frame.height = orig.height = height;
		
		if (!doNotResizeBase) {
			var baseRenderTexture:RenderTextureBase = cast baseTexture;
			baseRenderTexture.resize(width, height);
		}
	}
	
	static public function create(width:Float, height:Float, ?resolution:Float):RenderTexture {
		return new RenderTexture(new RenderTextureBase(width, height, resolution));
	}
}