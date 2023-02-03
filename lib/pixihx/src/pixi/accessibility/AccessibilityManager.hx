package pixi.accessibility;
import isMobile.Device;
import js.Browser;
import js.html.DOMRect;
import js.html.FocusEvent;
import js.html.HtmlElement;
import js.html.KeyboardEvent;
import js.html.MouseEvent;
import pixi.core.display.DisplayObject;
import pixi.core.display.DisplayObjectContainer;
import pixi.core.geom.shape.Rectangle;
import pixi.core.renderer.Renderer;
import pixi.core.renderer.RendererBase;
import pixi.core.renderer.RendererEventKind;
import pixi.io.IOManager;

/**
 * ...
 * @author leonaci
 */
class AccessibilityManager {
	@:extern static inline private var DIV_TOUCH_SIZE:Int = 100;
	@:extern static inline private var DIV_TOUCH_POS_X:Int = 0;
	@:extern static inline private var DIV_TOUCH_POS_Y:Int = 0;
	@:extern static inline private var DIV_TOUCH_ZINDEX:Int = 2;

	@:extern static inline private var DIV_HOOK_SIZE:Int = 1;
	@:extern static inline private var DIV_HOOK_POS_X:Int = -1000;
	@:extern static inline private var DIV_HOOK_POS_Y:Int = -1000;
	@:extern static inline private var DIV_HOOK_ZINDEX:Int = 2;
	
	public var div(default, null):HtmlElement;
	
	private var pool:Array<HtmlElement>;
	
	private var debug:Bool;
	
	public var renderId(default, null):Int;
	private var renderer:Renderer;
	
	private var children:Array<DisplayObject>;
	
	private var isActive:Bool;
	private var isMobileAccessibility:Bool;
	
	private var io:IOManager;
	
	public function new(renderer:Renderer) {
		if ((Device.tablet || Device.phone)) createTouchHook();
		
		var div:HtmlElement = cast Browser.document.createElement('div', '');
		
		div.style.widows = '${DIV_TOUCH_SIZE}px';
		div.style.height = '${DIV_TOUCH_SIZE}px';
        div.style.position = 'absolute';
        div.style.top = '${DIV_TOUCH_POS_X}px';
        div.style.left = '${DIV_TOUCH_POS_Y}px';
        div.style.zIndex = '${DIV_TOUCH_ZINDEX}';
		
		this.div = div;
		
		debug = false;
		
		renderId = 0;
		this.renderer = renderer;
		
		children = [];
		pool = [];
		
		isActive = false;
		isMobileAccessibility = false;
		
		Browser.window.addEventListener('keydown', onKeyDown, false);
	}
	
	private function createTouchHook():Void {
		var hookDiv = Browser.document.createElement('button', '');
		
        hookDiv.style.width = '${DIV_HOOK_SIZE}px';
        hookDiv.style.height = '${DIV_HOOK_SIZE}px';
        hookDiv.style.position = 'absolute';
        hookDiv.style.top = '${DIV_HOOK_POS_X}px';
        hookDiv.style.left = '${DIV_HOOK_POS_Y}px';
        hookDiv.style.zIndex = '${DIV_HOOK_ZINDEX}';
        hookDiv.style.backgroundColor = '#FF0000';
        hookDiv.title = 'HOOK DIV';
		
		hookDiv.addEventListener('focus', ()->{
			isMobileAccessibility = true;
			activate();
			Browser.document.body.removeChild(hookDiv);
		});
		
		Browser.document.body.appendChild(hookDiv);
	}
	
	private function activate():Void {
		if (isActive) return;
		
		isActive = true;
		
		Browser.document.addEventListener('mousemove', onMouseMove, true);
		Browser.document.addEventListener('keydown', onKeyDown, false);
		
		renderer.on(RendererEventKind.Postrender, update);
		
		if (renderer.view.parentNode != null) renderer.view.parentNode.appendChild(div);
	}
	
	private function deactivate():Void {
		if (!isActive || isMobileAccessibility) return;
		
		isActive = false;
		
		Browser.document.removeEventListener('mousemove', onMouseMove, true);
		Browser.document.removeEventListener('keydown', onKeyDown, false);
		
		renderer.off(RendererEventKind.Postrender, update);
		
		if (div.parentNode != null) div.parentNode.removeChild(div);
	}
	
	private function update():Void {
		if (!renderer.renderingToScreen) return;
		
		if(renderer.lastObjectRendered != null) updateAccessibleObjects(renderer.lastObjectRendered);
		
		var rect:DOMRect = renderer.view.getBoundingClientRect();
		var sx = rect.width / renderer.width;
		var sy = rect.height / renderer.height;
		
        div.style.left = '${rect.left}px';
        div.style.top = '${rect.top}px';
        div.style.width = '${renderer.width}px';
        div.style.height = '${renderer.height}px';
		
		var childrenTmp = children;
		for (child in childrenTmp) {
			if (child.target.renderId != renderId) {
				children.remove(child);
				div.removeChild(child.target.accessibleDiv);
				pool.push(child.target.accessibleDiv);
				child.target.accessibleDiv = null;
				
				if (children.length == 0) deactivate();
			}
			else {
				div = child.target.accessibleDiv;
				var hitArea:Rectangle = child.getGlobalBoundsRect();
				
				div.style.left = '${hitArea.x * sx}px';
				div.style.top = '${hitArea.y * sy}px';
				
				div.style.width = '${hitArea.width * sx}px';
				div.style.height = '${hitArea.height * sy}px';
			}
		}
		
		childrenTmp = null;
		renderId++;
	}
	
	private inline function updateAccessibleObjects(object:DisplayObject):Void {
		if (!object.visible) return;
		
		if (object.target.accessible) {
			if (!object.target.accessibleActive) addChild(object);
			object.target.renderId = renderId;
		}
		
		if (Std.is(object, DisplayObjectContainer)) {
			var container:DisplayObjectContainer = cast object;
			for (child in container.children) updateAccessibleObjects(child);
		}
	}
	
	private inline function capHitArea(hitArea:Rectangle):Void {
		if (hitArea.x < 0) {
			hitArea.width += hitArea.x;
			hitArea.x = 0;
		}
		
		if (hitArea.y < 0) {
			hitArea.height += hitArea.y;
			hitArea.y = 0;
		}
		
		if (hitArea.x + hitArea.width > renderer.width) {
			hitArea.width = renderer.width - hitArea.x;
		}
		
		if (hitArea.y + hitArea.height > renderer.height) {
			hitArea.height = renderer.height - hitArea.y;
		}
	}
	
	private function addChild(object:DisplayObject):Void {
		var objectDiv:HtmlElement = pool.pop();
		
		if (objectDiv == null) {
			objectDiv = cast Browser.document.createElement('button', '');
			
			objectDiv.style.width = '${DIV_TOUCH_SIZE}px';
			objectDiv.style.height = '${DIV_TOUCH_SIZE}px';
			objectDiv.style.backgroundColor = this.debug ? 'rgba(255,0,0,0.5)' : 'transparent';
			objectDiv.style.position = 'absolute';
			objectDiv.style.zIndex = '${DIV_TOUCH_ZINDEX}';
			objectDiv.style.borderStyle = 'none';
			
			objectDiv.addEventListener('click', onClick);
			objectDiv.addEventListener('focus', onFocus);
			objectDiv.addEventListener('focusout', onFocusOut);
		}
		
		var target = object.target;
		if (target.accessibleTitle != null) {
			objectDiv.title = target.accessibleTitle;
		}
		else if (target.accessibleTitle == null && target.accessibleHint == null) {
			objectDiv.title = 'displayObject ${target.tabIndex}';
		}
		
		if (target.accessibleHint != null) {
			objectDiv.setAttribute('aria-label', target.accessibleHint);
		}
		
		target.accessibleActive = true;
		target.accessibleDiv = objectDiv;
		
		children.push(object);
		div.appendChild(objectDiv);
		objectDiv.tabIndex = target.tabIndex;
	}
	
	private function onClick(e:MouseEvent):Void {
		//io.distachEvent();
	}
	
	private function onFocus(e:FocusEvent):Void {
		//io.distachEvent();
	}
	
	private function onFocusOut(e:FocusEvent):Void {
		//io.distachEvent();
	}
	
	private function onKeyDown(e:KeyboardEvent):Void {
		if (e.keyCode != KeyboardEvent.DOM_VK_TAB) return;
		
		activate();
	}
	
	private function onMouseMove():Void {
		deactivate();
	}
	
	public function dispose():Void {
		div = null;
		
		for (child in children) child.target.accessibleDiv = null;
		
		Browser.document.removeEventListener('mousemove', onMouseMove);
		Browser.document.removeEventListener('keydown', onKeyDown);
		
		pool = null;
		children = null;
		renderer = null;
	}
}
