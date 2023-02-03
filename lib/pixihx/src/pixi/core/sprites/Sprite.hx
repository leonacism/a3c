package pixi.core.sprites;
import haxe.ds.Option;
import pixi.core.display.DisplayObjectContainer;
import pixi.core.geom.point.ObservablePoint;
import pixi.core.geom.shape.Rectangle;
import pixi.core.renderer.Renderer;
import pixi.core.texture.Texture;
import pixi.core.texture.TextureEventKind;
import pixi.core.texture.TextureLoadPhase;
import pixi.util.BlendMode;
import pixi.util.Color;
import pixi.util.MathUtil;
import pixi.util.PixiError;

/**
 * ...
 * @author leonaci
 */
class Sprite extends DisplayObjectContainer {
	override function get_width():Float {
		return MathUtil.abs(scale.x) * texture.orig.width;
	}
	
	override function set_width(width:Float):Float {
		scale.x = MathUtil.sign(scale.x) * width / texture.orig.width;
		return width;
	}
	
	override function get_height():Float {
		return MathUtil.abs(scale.y) * texture.orig.height;
	}
	
	override function set_height(height:Float):Float {
		scale.y = MathUtil.sign(scale.y) * height / texture.orig.height;
		return height;
	}
	
	public var blendMode:BlendMode;
	public var tint:Color;
	
	public var anchor(default, null):ObservablePoint;
	inline function onAnchorUpdate():Void {
		pivot.x = anchor.x * width;
		pivot.y = anchor.y * height;
	}
	
	public var texture(default, set):Texture;
	inline function set_texture(texture:Texture):Texture {
		if (this.texture == texture) return texture;
		
		this.texture = texture;
		
		switch(texture.phase) {
			case TextureLoadPhase.Completed(src, _):
				onTextureUpdate();
				
			case _:
				texture.once(TextureEventKind.Update, onTextureUpdate);
		}
		
		return texture;
	}
	
	
	public var vertices(default, null):Array<Float>;
	
	public function new(texture:Texture) {
		super();
		
		blendMode = BlendMode.Normal;
		tint = pixi.util.Color.Hex(0xFFFFFF, 1.0);
		
		anchor = new ObservablePoint(onAnchorUpdate);
		
		this.texture = texture;
		
		
		vertices = [];
	}
	
	private inline function onTextureUpdate():Void {
	}
	
	@:access(pixi.core.texture.Texture)
	private function calculateVertices():Void {
		if (!transform.globalDirty && !texture.updateDirty) return;
		
		transform.globalDirty = false;
		texture.updateDirty = false;
		
		var g = transform.global;
		var a = g.a;
		var b = g.b;
		var c = g.c;
		var d = g.d;
		var tx = g.tx;
		var ty = g.ty;
		
		var w0 = 0.0;
		var w1 = 0.0;
		var h0 = 0.0;
		var h1 = 0.0;
		
		var trim = texture.trim;
		
		switch (trim) {
			case Option.Some(trim):
				w0 = trim.x - (anchor.x * texture.width);
				w1 = w0 + trim.width;
				h0 = trim.y - (anchor.y * texture.height);
				h1 = h0 + trim.height;
				
			case Option.None:
				w0 = -anchor.x * texture.width;
				w1 = w0 + texture.width;
				h0 = -anchor.y * texture.height;
				h1 = h0 + texture.height;
		}
		vertices[0] = a * w0 + b * h0 + tx;
		vertices[1] = c * w0 + d * h0 + ty;
		
		vertices[2] = a * w1 + b * h0 + tx;
		vertices[3] = c * w1 + d * h0 + ty;
		
		vertices[4] = a * w1 + b * h1 + tx;
		vertices[5] = c * w1 + d * h1 + ty;
		
		vertices[6] = a * w0 + b * h1 + tx;
		vertices[7] = c * w0 + d * h1 + ty;
	}
	
	override function renderContainer(renderer:Renderer):Void 
	{
		calculateVertices();
		
		renderer.setDisplayObjectRenderer(renderer.sprite);
		renderer.sprite.render(this);
	}
	
	override function calculateBounds():Void 
	{
		var orig = texture.orig;
		var trim = texture.trim;
		
		switch(trim) {
			case Option.Some(trim) if(orig.width != trim.width || orig.height != trim.height):
				bounds.addQuad(vertices);
				
			case _:
				calculateVertices();
				bounds.addQuad(vertices);
		}
	}
	
	override public function getLocalBoundsRect():Rectangle 
	{
		if (children.length == 0) {
			bounds.minX = - anchor.x * texture.orig.width;
			bounds.minY = - anchor.y * texture.orig.height;
			bounds.maxX = (1 - anchor.x) * texture.orig.width;
			bounds.maxY = (1 - anchor.y) * texture.orig.height;
			
			var rect:Rectangle = bounds.getRectangle();
			if (localBoundsRectangle == null) localBoundsRectangle = rect;
			
			return rect;
		}
		
		return super.getLocalBoundsRect();
	}
	
	
	override public function dispose():Void 
	{
		super.dispose();
		
		anchor = null;
		
		texture.dispose();
		texture = null;
	}
	
	static public function from(source:String):Sprite {
		return new Sprite(Texture.fromImage(source));
	}
	
	static public function fromFrame(frameID:String):Sprite {
		return if (Texture.textureCache.exists(frameID)) new Sprite(Texture.textureCache[frameID]);
		else throw new PixiError('The frameID \"${frameID}\" does not exist in the texture cache.');
	}
}