package chainer.testing.attr;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.testing.attr') extern class Attr_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _dummy_callable(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>) : Dynamic;
	static public var _error : Dynamic;
	static public function check_available() : Dynamic;
	static public function cudnn(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>) : Dynamic;
	static public function get_error() : Dynamic;
	/**
		Decorator to indicate that GPU is required to run the test.
		Tests can be annotated with this decorator (e.g., ``@gpu``) to
		declare that one GPU is required to run.
	**/
	static public function gpu(f:Dynamic) : Dynamic;
	static public function is_available() : Dynamic;
	/**
		Decorator to indicate number of GPUs required to run the test.
		Tests can be annotated with this decorator (e.g., ``@multi_gpu(2)``) to
		declare number of GPUs required to run. When running tests, if
		``CHAINER_TEST_GPU_LIMIT`` environment variable is set to value greater
		than or equals to 0, test cases that require GPUs more than the limit will
		be skipped.
	**/
	static public function multi_gpu(gpu_num:Dynamic) : Dynamic;
	static public function slow(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>) : Dynamic
}