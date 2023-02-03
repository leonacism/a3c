package pixi.core.util.handler;
import pixi.util.PixiError;

/**
 * 型Tの関数listをwrapするクラス
 * @author leonaci
 */
class GenericDispatcher<T> {
	public var handlers(get, never):Array<T>;
	inline function get_handlers():Array<T> return cast onHandlers.concat(onceHandlers);
	
	public var length(get, never):Int;
	inline function get_length():Int return onHandlers.length + onceHandlers.length;
	
	private var onHandlers:Array<Handler<T>>;
	private var onceHandlers:Array<Handler<T>>;
	
	private var consumer:Consumer<Handler<T>>;
	
	private var lock:Bool;
	
	public function new(consumer:Consumer<Handler<T>>) {
		this.consumer = consumer;
		
		lock = false;
		
		clear();
	}
	
	private function clear():Void {
		onHandlers = [];
		onceHandlers = [];
	}
	
	inline public function add(f:T, once:Bool):Handler<T> {
		var handler = new Handler(f);
		var hs = once? onceHandlers : onHandlers;
		hs = consumer(hs, handler);
		return handler;
	}
	
	inline public function remove(f:T):Void {
		if(lock) throw new PixiError('dispatcher being locked.');
		
		onHandlers.remove(f);
		onceHandlers.remove(f);
	}
	
	inline public function execute(treat:Handler<T>->Void):Void {
		if (lock) throw new PixiError('dispatcher being locked.');
		lock = true;
		
		var onceHandlers_ = onceHandlers;
		onceHandlers = [];
		
		for (handler in onHandlers) treat(handler);
		for (handler in onceHandlers_) treat(handler);
		
		onceHandlers_ = null;
		
		lock = false;
	}
}