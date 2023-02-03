package pixi.core.display;
import haxe.ds.Option;
import pixi.accessibility.AccessibleTarget;
import pixi.core.geom.Affine;
import pixi.core.geom.Bounds;
import pixi.core.geom.point.ObservablePoint;
import pixi.core.geom.point.Point;
import pixi.core.geom.shape.Rectangle;
import pixi.core.geom.transform.ITransform;
import pixi.core.geom.transform.Transform;
import pixi.core.geom.transform.TransformProperty;
import pixi.core.renderer.Renderer;
import pixi.core.util.event.EventListener;
import pixi.util.PixiError;

/**
 * ...
 * @author leonaci
 */
class DisplayObject extends EventListener<DisplayObjectEventKind> {
	public var x(get, set):Float;
	inline function get_x():Float return transform.position.x;
	inline function set_x(x:Float):Float return transform.position.x = x;
	
	public var y(get, set):Float;
	inline function get_y():Float return transform.position.y;
	inline function set_y(y:Float):Float return transform.position.y = y;
	
	public var scale(get, never):Point;
	inline function get_scale():Point return transform.scale;
	
	public var skew(get, never):ObservablePoint;
	inline function get_skew():ObservablePoint return transform.skew;
	
	public var pivot(get, never):Point;
	inline function get_pivot():Point return transform.pivot;
	
	public var rotation(get, set):Float;
	inline function get_rotation():Float return transform.rotation;
	inline function set_rotation(rotation:Float):Float return transform.rotation = rotation;
	
	public var global(get, never):Affine;
	inline function get_global():Affine return transform.global;
	
	public var local(get, never):Affine;
	inline function get_local():Affine return transform.local;
	
	private var transform:ITransform;
	
	public var parent(default, null):Option<DisplayObjectContainer>;
	
	public var globalAlpha(get, never):Float;
	inline function get_globalAlpha():Float {
		return switch(parent) {
			case Option.Some(parent): alpha * parent.globalAlpha;
			case Option.None: alpha;
		}
	}
	
	public var globalVisible(get, never):Bool;
	inline function get_globalVisible():Bool {
		return switch(parent) {
			case Option.Some(parent): visible && parent.globalVisible;
			case Option.None: visible;
		}
	}
	
	/** the opacity of the object */
	public var alpha:Float;
	public var visible:Bool;
	public var renderable(default, null):Bool;
	
	private var bounds:Bounds;
	private var boundsRectangle:Rectangle;
	private var localBoundsRectangle:Rectangle;
	private var boundsDirty:Bool;
	
	public var target(default, null):AccessibleTarget;
	
	public function new() {
		super();
		
		transform = new Transform();
		
		parent = Option.None;
		
		alpha = 1.0;
		visible = true;
		renderable = true;
		
		bounds = new Bounds();
		boundsRectangle = new Rectangle();
		localBoundsRectangle = new Rectangle();
		boundsDirty = false;
		
		target = {};
	}
	
	public function render(renderer:Renderer):Void {
		invoke(DisplayObjectEventKind.Frame);
	}
	
	public function updateTransform():Void {
		switch(parent) {
			case Option.Some(parent):
				transform.updateGlobalTransform(parent.transform);
				
			case Option.None:
				transform.updateGlobalTransform(Transform.IDENTITY);
		}
	}
	
	public inline function updateLocalTransform():Void {
		var parentTmp = parent;
		
		parent = Option.None;
		
		updateTransform();
		
		parent = parentTmp;
	}
	
	private inline function updateRootTransform():Void {
		switch(parent) {
			case Option.Some(parent): 
				parent.updateRootTransform();
				transform.updateGlobalTransform(parent.transform);
				
			case Option.None:
				transform.updateGlobalTransform(Transform.IDENTITY);
		}
	}
	
	private function calculateBounds():Void {
		bounds.clear();
		
		calculateDisplayObjectBounds();
		
		boundsDirty = false;
	}
	
	private function calculateDisplayObjectBounds():Void {
		throw new PixiError('this method not implemented. it must be overridden.');
	}
	
	public function getGlobalBoundsRect(?skipUpdate:Bool=false):Rectangle {
		if (!skipUpdate) updateRootTransform();
		
		if (boundsDirty) calculateBounds();
		
		return boundsRectangle = bounds.getRectangle();
	}
	
	public function getLocalBoundsRect():Rectangle {
		var parentTmp = parent;
		
		parent = Option.None;
		
		var rect = getGlobalBoundsRect();
		
		parent = parentTmp;
		
		return localBoundsRectangle = rect;
	}
	
	public function toGlobalPosition(origin:Point, ?skipUpdate:Bool = false):Point {
		if (!skipUpdate) updateRootTransform();
		
		return (transform.global) * origin;
	}
	
	public function toLocalPosition(origin:Point, ?from:DisplayObject, ?skipUpdate:Bool = false):Point {
		if(from!=null) origin = from.toGlobalPosition(origin, skipUpdate);
		
		if (!skipUpdate) updateRootTransform();
		
		return (~transform.global) * origin;
	}
	
	public function setTransform(property:TransformProperty):Void {
		x        = property.x==null? 0 : property.x;
		y        = property.y==null? 0 : property.y;
		scale.x  = property.scaleX==0 || property.scaleX==null? 1 : property.scaleX;
		scale.y  = property.scaleY==0 || property.scaleY==null? 1 : property.scaleY;
		skew.x   = property.skewX==null? 0 : property.skewX;
		skew.y   = property.skewY==null? 0 : property.skewY;
		pivot.x  = property.pivotX==null? 0 : property.pivotX;
		pivot.y  = property.pivotY==null? 0 : property.pivotY;
		rotation = property.rotation==null? 0 : property.rotation;
	}
	
	public function setParent(container:DisplayObjectContainer):DisplayObjectContainer {
		container.addChild(this);
		return container;
	}
	
	public function addFrameHandler(handler:Void->Void):Void {
		on(DisplayObjectEventKind.Frame, handler);
	}
	
	public function dispose():Void {
		clearAll();
		
		switch(parent) {
			case Option.Some(p): p.removeChild(this);
			case Option.None:
		}
		
		transform = null;
		parent = null;
		
		bounds = null;
		boundsRectangle = null;
	}
}