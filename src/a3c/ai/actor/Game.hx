package a3c.ai.actor;
import q.Channel;
import q.Q;

/**
 * ...
 * @author ...
 */
class Game {
	public var initializer(default,null):Sender<Dynamic>;
	public var action_observer(default,null):Sender<Dynamic>;
	public var state_notifier(default,null):Sender<Dynamic>;
	public var renderer(default,null):Sender<Dynamic>;
	
	public function init() : Cont<Dynamic> throw '!?';
}