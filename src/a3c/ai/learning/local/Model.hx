package a3c.ai.learning.local;
import chainer.Optimizer;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('worker', 'Worker') extern class Model {
	function new(id:String):Void;
	function value(input:Dynamic):Dynamic;
	function serialize():Void;
	function fetch_params():String;
	function copy_params(source:Model):Void;
	function copy_grads(source:Model):Void;
	function apply_grads(optimizer:Optimizer):Void;
	function update_grads(episode:Dynamic):Void;
}
