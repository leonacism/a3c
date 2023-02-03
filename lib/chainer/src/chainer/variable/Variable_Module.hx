package chainer.variable;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.variable') extern class Variable_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _check_grad_type(func:Dynamic, x:Dynamic, gx:Dynamic) : Dynamic;
	static public function _create_variable(data:Dynamic, name:Dynamic, grad:Dynamic, requires_grad:Dynamic) : Dynamic;
	static public function _recover_parameter(data:Dynamic, name:Dynamic, grad:Dynamic, initializer:Dynamic, update_rule:Dynamic) : Dynamic;
	/**
		Converts an array or a variable into :class:`~chainer.Variable`.
		This is a convenient function to get a :class:`~chainer.Variable` object
		transparently from a raw array or a variable.
		Note that this function should only be used for type consistency (i.e., to
		enforce the return value of an API having type :class:`~chainer.Varialbe`).
		The :class:`~chainer.Variable.requires_grad` flag is kept as is; if ``obj``
		is a raw array, the newly created variable has ``requires_grad = False``.
		In order to make a variable w.r.t. which you want to compute the gradient,
		you should use :class:`~chainer.Variable` directly.
		Args:
			obj (numpy.ndarray or cupy.ndarray or ~chainer.Variable): An array or
				a variable that you want to convert to :class:`~chainer.Variable`.
		Returns:
			~chainer.Variable:
			A variable converted from ``obj``. If ``obj`` is a raw array, this is a
			new :class:`~chainer.Variable` object that wraps the array. If ``obj``
			is already a :class:`~chainer.Variable` object, this function returns
			``obj`` as is.
	**/
	static public function as_variable(obj:Dynamic) : Dynamic;
	/**
		Return the string representation of a variable.
		Args:
			var (~chainer.Variable): Input Variable.
		.. seealso:: numpy.array_repr
	**/
	static public function variable_repr(_var:Dynamic) : Dynamic;
	/**
		Return the string representation of a variable.
		Args:
			var (~chainer.Variable): Input Variable.
		.. seealso:: numpy.array_str
	**/
	static public function varaible_str(_var:Dynamic) : Dynamic;
}