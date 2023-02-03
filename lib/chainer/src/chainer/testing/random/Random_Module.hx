package chainer.testing.random;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.testing.random') extern class Random_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _check_teardown() : Dynamic;
	static public var _nest_count : Dynamic;
	static public function _numpy_do_setup(?deterministic:Dynamic) : Dynamic;
	static public function _numpy_do_teardown() : Dynamic;
	static public var _old_numpy_random_state : Dynamic;
	static public var _old_python_random_state : Dynamic;
	/**
		Sets up the deterministic random states of ``numpy`` and ``cupy``.
	**/
	static public function _setup_random() : Dynamic;
	/**
		Tears down the deterministic random states set up by ``_setup_random``.
	**/
	static public function _teardown_random() : Dynamic;
	static public function do_setup(?deterministic:Dynamic) : Dynamic;
	static public function do_teardown() : Dynamic;
	/**
		Decorator that fixes random numbers in a test.
		This decorator can be applied to either a test case class or a test method.
		It should not be applied within ``condition.retry`` or
		``condition.repeat``.
	**/
	static public function fix_random() : Dynamic;
	/**
		
	**/
	static public function generate_seed() : Dynamic;
}