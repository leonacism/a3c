package pixi.core.texture;
import pixi.core.renderer.RenderTarget;

/**
 * ...
 * @author leonaci
 */
class RenderTextureBase extends TextureBase {
	public var glRenderTargets(default, null):Array<RenderTarget>;

	public function new(?width:Float=100, ?height:Float=100, ?resolution:Float) {
		super(null, resolution);
		
		resize(width, height);
		
		glRenderTargets = [];
	}
	
	public function resize(width:Float, height:Float):Void {
		if (this.width == width && this.height == height) return;
		
		realWidth = width * resolution;
		realHeight = height * resolution;
	}
	
	override public function dispose():Void {
		super.dispose();
		glRenderTargets = null;
	}
}