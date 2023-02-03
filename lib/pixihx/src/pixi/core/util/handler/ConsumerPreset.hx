package pixi.core.util.handler;

/**
 * ...
 * @author leonaci
 */
abstract ConsumerPreset<T>(Consumer<Handler<T>>) to Consumer<Handler<T>>
{
	static inline public function IN_ORDER<T>(hs:Array<Handler<T>>, h:Handler<T>):Array<Handler<T>> {
		hs.push(h);
		return hs;
	}
	
	static inline public function REVERSAL<T>(hs:Array<Handler<T>>, h:Handler<T>):Array<Handler<T>> {
		hs.unshift(h);
		return hs;
	}
}