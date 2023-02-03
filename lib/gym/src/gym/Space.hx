package gym;
import gym.DataType;
import python.Tuple;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('gym.Space')
extern class Space {
	public var shape:Tuple<Int>;
	public var dtype:DataType;
	
	public function new(shape:Tuple<Int>, dtype:DataType):Void;

	public function sample():Dynamic;
	public function contains(x:Dynamic):Bool;
}