package chainer.testing.array;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.testing.array') extern class Array_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Asserts if some corresponding element of x and y differs too much.
		This function can handle both CPU and GPU arrays simultaneously.
		Args:
			x: Left-hand-side array.
			y: Right-hand-side array.
			atol (float): Absolute tolerance.
			rtol (float): Relative tolerance.
			verbose (bool): If ``True``, it outputs verbose messages on error.
	**/
	static public function assert_allclose(x:Dynamic, y:Dynamic, ?atol:Dynamic, ?rtol:Dynamic, ?verbose:Dynamic) : Dynamic;
}