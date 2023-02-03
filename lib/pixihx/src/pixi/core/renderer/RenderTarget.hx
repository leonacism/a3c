package pixi.core.renderer;
import haxe.ds.Option;
import js.html.webgl.GL;
import pixi.core.graphics.Graphics;
import pixi.util.Color;
import pixi.core.geom.Affine;
import pixi.core.geom.shape.Rectangle;
import pixi.gl.GLBuffer;
import pixi.gl.GLFrameBuffer;
import pixi.gl.GLTexture;
import pixi.util.Constant.ScaleMode;

/**
 * ...
 * @author leonaci
 */
class RenderTarget
{
	private var gl:GL;
	private var frameBuffer:GLFrameBuffer;
	public var texture(default, null):GLTexture;
	
	private var size:Rectangle;
	public var scaleMode(default, null):ScaleMode;
	public var resolution(default, null):Float;
	public var root(default, null):Bool;
	
	public var backgroundColor:Color;
	
	public var transform(null, set):Option<Affine>;
	inline function set_transform(transform:Option<Affine>):Option<Affine> return this.transform = transform;
	
	public var projectionMatrix(default, null):Affine;
	
	private var defaultFrame:Rectangle;
	private var destinationFrame:Rectangle;
	private var sourceFrame:Rectangle;
	
	private var stencilBuffer:GLBuffer;
	private var stencilMaskStack:Array<Graphics>;
	
	
	public function new(gl:GL, ?width:Float=0, ?height:Float=0, ?scaleMode:ScaleMode, ?resolution:Float=1, ?root:Bool=false) {
		this.gl = gl;
		
		size = new Rectangle(0, 0, width, height);
		this.scaleMode = scaleMode!=null? scaleMode : Config.SCALE_MODE;
		this.resolution = resolution;
		this.root = root;
		
		switch(root) {
			case true:
				frameBuffer = GLFrameBuffer.createPlain(gl);
				
			case false:
				frameBuffer = GLFrameBuffer.createRGBA(gl, 100, 100);
				switch(scaleMode) {
					case ScaleMode.Linear:
						frameBuffer.texture.enableLinearScaling();
					case ScaleMode.Nearest:
						frameBuffer.texture.enableNearestScaling();
				}
				texture = frameBuffer.texture;
		}
		
		backgroundColor = Color.Rgba(0, 0, 0, 0);
		
		transform = Option.None;
		projectionMatrix = new Affine();
		
		defaultFrame = new Rectangle(0, 0, width, height);
		destinationFrame = defaultFrame;
		sourceFrame = defaultFrame;
		resize(width, height);
		
		stencilBuffer = null;
		stencilMaskStack = [];
	}
	
	public inline function clear(?color:Color):Void {
		var c = color!=null? color : backgroundColor;
		frameBuffer.clear(c.r, c.g, c.b, c.a);
	}
	
	public function attachStencilBuffer():Void {
		if (!root) frameBuffer.enableStencil();
	}
	
	public function setFrame(destinationFrame:Rectangle, sourceFrame:Rectangle):Void {
		this.destinationFrame = destinationFrame;
		this.sourceFrame = sourceFrame;
	}
	
	public function activate():Void {
		frameBuffer.bind();
		
		calculateProjection(destinationFrame, sourceFrame);
		
		switch(transform) {
			case Option.Some(transform):
				projectionMatrix = transform * projectionMatrix;
			case Option.None:
		}
		
		if (destinationFrame != sourceFrame) {
			gl.enable(GL.SCISSOR_TEST);
			gl.scissor(
				Std.int(destinationFrame.x),
				Std.int(destinationFrame.y),
				Std.int(destinationFrame.width  * resolution),
				Std.int(destinationFrame.height * resolution)
			);
		}
		else gl.disable(GL.SCISSOR_TEST);
		
		gl.viewport(
			Std.int(destinationFrame.x),
			Std.int(destinationFrame.y),
			Std.int(destinationFrame.width  * resolution),
			Std.int(destinationFrame.height * resolution)
		);
	}
	
	private function calculateProjection(dest:Rectangle, src:Rectangle):Void {
		var pm = projectionMatrix.identity();
		
		if (!root) {
			pm.a = 2 / dest.width;
			pm.d = 2 / dest.height;
			pm.tx = -1 - src.x * pm.a;
			pm.ty = -1 - src.y * pm.d;
		}
		else {
			pm.a =  2 / dest.width;
			pm.d = -2 / dest.height;
			pm.tx = -1 - src.x * pm.a;
			pm.ty =  1 - src.y * pm.d;
		}
	}
	
	public function resize(width:Float, height:Float):Void {
		if (size.width == width && size.height == height) return;
		
		size.width = width;
		size.height = height;
		
		defaultFrame.width = width;
		defaultFrame.height = height;
		
		frameBuffer.resize(Std.int(width * resolution), Std.int(height * resolution));
		
		calculateProjection(size, size);
	}
	
	public function dispose():Void {
		frameBuffer.dipose();
		
		gl = null;
		frameBuffer = null;
		texture = null;
		
		backgroundColor = null;
		size = null;
		projectionMatrix = null;
		transform = null;
		
		defaultFrame = null;
		destinationFrame = null;
		sourceFrame = null;
		
		stencilBuffer = null;
		stencilMaskStack = null;
		
		scaleMode = null;
	}
}