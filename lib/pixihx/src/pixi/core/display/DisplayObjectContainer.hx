package pixi.core.display;
import haxe.ds.Option;
import pixi.core.renderer.Renderer;

/**
 * ...
 * @author leonaci
 */
class DisplayObjectContainer extends DisplayObject {
	
	public var width(get, set):Float;
	function get_width():Float return scale.x * getLocalBoundsRect().width;
	function set_width(width:Float):Float {
		var currentWidth = getLocalBoundsRect().width;
		scale.x = (width != 0)? width / currentWidth : 1;
		return width;
	}
	
	public var height(get, set):Float;
	function get_height():Float return scale.y * getLocalBoundsRect().height;
	function set_height(height:Float):Float {
		var currentHeight = getLocalBoundsRect().height;
		scale.y = (height != 0)? height / currentHeight : 1;
		return height;
	}
	
	public var children(default, null):Array<DisplayObject>;
	
	public function new() {
		super();
		
		children = [];
	}
	
	override public function render(renderer:Renderer):Void {
		invoke(DisplayObjectEventKind.Frame);
		
		if (!visible || !renderable || globalAlpha <= 0) return;
		
		renderContainer(renderer);
		
		for (child in children) child.render(renderer);
	}
	
	private function renderContainer(renderer:Renderer):Void {
		
	}
	
	public function addChild(child:DisplayObject):DisplayObject {
		switch(child.parent) {
			case Option.Some(p): p.removeChild(child);
			case Option.None:
		}
		child.parent = Option.Some(this);
		
		children.push(child);
		
		boundsDirty = true;
		
		return child;
	}
	
	public function removeChild(child:DisplayObject):DisplayObject {
		if (children.indexOf(child) == -1) return null;
		child.parent = Option.None;
		
		children.remove(child);
		
		boundsDirty = true;
		
		return child;
	}
	
	public function iterator():Iterator<DisplayObject> return children.iterator();
	
	override public function updateTransform():Void {
		super.updateTransform();
		
		for (child in children) if (child.visible && child.renderable) {
			child.updateTransform();
		}
	}
	
	override private function calculateBounds():Void {
		bounds.clear();
		
		calculateDisplayObjectBounds();
		
		for (child in children) {
			if (!child.visible || !child.renderable) continue;
			
			child.calculateBounds();
			
			bounds.addBounds(child.bounds);
		}
		
		boundsDirty = false;
	}
	
	override public function dispose():Void {
		super.dispose();
		
		var _children = children.copy();
		for (child in _children) {
			child.dispose();
			children.remove(child);
		}
		_children = null;
	}
}