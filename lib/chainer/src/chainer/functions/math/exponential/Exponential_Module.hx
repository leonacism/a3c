package chainer.functions.math.exponential;

/**
 * ...
 * @author 
 */
@:pythonImport('chainer.functions.math.exponential') extern class Exponential_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Elementwise exponential function.
	**/
	static public function exp(x:Dynamic) : Dynamic;
	/**
		Elementwise natural logarithm function.
	**/
	static public function log(x:Dynamic) : Dynamic;
	/**
		Elementwise logarithm function to the base 2.
		.. math::
		   y_i = \\log_2 x_i.
		Args:
			x (~chainer.Variable): Input variable.
		Returns:
			~chainer.Variable: Output variable.
	**/
	static public function log2(x:Dynamic) : Dynamic;
	/**
		Elementwise logarithm function to the base 10.
		.. math::
		   y_i = \\log_{10} x_i.
		Args:
			x (~chainer.Variable): Input variable.
		Returns:
			~chainer.Variable: Output variable.
	**/
	static public function log10(x:Dynamic) : Dynamic;
}