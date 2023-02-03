package pixi.core.util.event;
import pixi.core.util.handler.RoleDispatcher;
import haxe.ds.Map;
import pixi.core.util.handler.ConsumerPreset;
import pixi.core.util.handler.GenericDispatcher;

/**
 * ...
 * @author leonaci
 */
class EventListener<Role:EnumValue> {
	private var events:RoleDispatcher<Role>;
	private var eventsCount:Int;

	public function new() {
		clearAll();
	}
	
	public function invoke(kind:Role):Bool {
		if (!events.exists(kind)) return false;
		
		events.execute(kind);
		
		return true;
	}
	
	public function on(kind:Role, handler:Void->Void) {
		addEventListener(kind, handler, false);
	}
	
	public function once(kind:Role, handler:Void->Void) {
		addEventListener(kind, handler, true);
	}
	
	private function addEventListener(kind:Role, handler:Void->Void, once:Bool):Void {
		if (!events.exists(kind)) eventsCount++;
		events.add(kind, handler, once);
	}
	
	public function off(kind:Role, handler:Void->Void):Void {
		removeEventListener(kind, handler);
	}
	
	private function removeEventListener(kind:Role, handler:Void->Void):Void {
		if (!events.exists(kind)) return;
		
		if (events.exists(kind)) events.remove(kind, handler);
	}
	
	public function clearEvent(kind:Role):Void {
		eventsCount--;
		if(eventsCount==0) events = new RoleDispatcher();
		else events.clear(kind);
	}
	
	public function clearAll():Void {
		events = new RoleDispatcher();
		eventsCount = 0;
	}
	
	public function countListeners(kind:Role):Int {
		if (!events.exists(kind)) return 0;
		
		return events.count(kind);
	}
}