package chainer.testing.parameterized;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.testing.parameterized') extern class Parameterized_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _gen_case(base:Dynamic, module:Dynamic, i:Dynamic, param:Dynamic) : Dynamic;
	static public function _gen_cases(name:Dynamic, base:Dynamic, params:Dynamic) : Dynamic;
	/**
		
	**/
	static public function parameterize(?params:python.VarArgs<Dynamic>) : Dynamic;
	/**
		
	**/
	static public function product(parameter:Dynamic) : Dynamic;
	/**
		
	**/
	static public function product_dict(?parameters:python.VarArgs<Dynamic>) : Dynamic;
}