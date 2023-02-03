package gym;
import python.Tuple;

/**
 * ...
 * @author leonaci
 */
@:native('gym.Env')
extern class Env {
	public var action_space(default,null):Discrete;
	public var observation_space(default,null):Space;
	
	public function step(action:Int):Tuple<Dynamic>;
	public function reset():Dynamic;
	public function render(?mode:String):Dynamic;
	public function close():Void;
	public function seed(?seed:Int):Array<Int>;
}