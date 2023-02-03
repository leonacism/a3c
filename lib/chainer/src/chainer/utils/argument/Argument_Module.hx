package chainer.utils.argument;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.utils.argument') extern class Argument_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function assert_kwargs_empty(kwargs:Dynamic) : Dynamic;
	static public function check_unexpected_kwargs(kwargs:Dynamic, ?unexpected:python.KwArgs<Dynamic>) : Dynamic;
	static public function parse_kwargs(kwargs:Dynamic, ?name_and_values:python.VarArgs<Dynamic>) : Dynamic;
}