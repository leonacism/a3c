package pixi.core.util;
import pixi.core.util.handler.ConsumerPreset;
import pixi.core.util.handler.GenericDispatcher;

/**
 * ...
 * @author leonaci
 */
class Observer<T> {
	private var dispatcher:GenericDispatcher<T->Void>;
	
	public function new() {
		dispatcher = new GenericDispatcher(ConsumerPreset.IN_ORDER);
	}
	
	public function observe(handler:T->Void):Void {
		dispatcher.add(handler, false);
	}
	
	public function notify(event:T):Void {
		dispatcher.execute(h->h(event));
	}
}