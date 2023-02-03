package chainer.gradient_check;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.gradient_check') extern class Gradient_Check_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _as_tuple(x:Dynamic) : Dynamic;
	static public function _clear_grads(xs:Dynamic) : Dynamic;
	static public function _copy_arrays(xs:Dynamic) : Dynamic;
	static public function _filter_list(lst:Dynamic, ignore_list:Dynamic) : Dynamic;
	static public function _set_y_grad(y:Dynamic, y_grad:Dynamic) : Dynamic;
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
	/**
		Test backward procedure of a given function.
		This function automatically checks the backward-process of a given function
		to ensure that the computed gradients are approximately correct.
		For example, assuming you've defined a :class:`~chainer.FunctionNode` class
		``MyFunc``, that takes two arguments and returns one value, you can wrap
		it in a ordinary function and check its gradient computations as follows::
		>> def test_my_func(self):
		>>
		>>     def func(xs):
		>>         y, = MyFunc().apply(xs)
		>>         return y
		>>
		>>   x1_data = xp.array(...)
		>>   x2_data = xp.array(...)
		>>   gy_data = xp.array(...)
		>>   check_backward(func, (x1_data, x2_data), gy_data)
		This method creates :class:`~chainer.Variable` objects with ``x_data``
		and calls ``func`` with the :class:`~chainer.Variable`\\ s to get its
		result as :class:`~chainer.Variable`.
		Then, it sets ``y_grad`` array to ``grad`` attribute of the result and
		calls ``backward`` method to get gradients of the inputs.
		To check correctness of the gradients, the function calls
		:func:`numerical_grad` to calculate numerically the gradients and compares
		the types of gradients with :func:`chainer.testing.assert_allclose`.
		To reduce computational time, it uses directional derivative along a
		random vector. A function
		:math:`g: \\mathbb{R} \\rightarrow \\mathbb{R}^n` is defined as
		:math:`g(\\delta) = f(x + \\delta r)`, where
		:math:`\\delta \\in \\mathbb{R}`, :math:`r \\in \\mathbb{R}^n`
		is a random vector
		and :math:`f` is a function which you want to test.
		Its gradient is
		.. math::
		   g'(\\delta) = f'(x + \\delta r) \\cdot r.
		Therefore, :math:`g'(0) = f'(x) \\cdot r`.
		So we can check the correctness of back propagation of :math:`f` indirectly
		by comparing this equation with the gradient of :math:`g` numerically
		calculated and that of :math:`f` computed by backprop.
		If :math:`r` is chosen from uniform distribution, we can conclude with
		high probability that the gradient of :math:`f` itself is correct.
		If input objects (``x1_data`` or/and ``x2_data`` in this example) represent
		integer variables, their gradients are ignored.
		You can simplify a test when ``MyFunc`` gets only one argument::
		>>   check_backward(func, x1_data, gy_data)
		If ``MyFunc`` is a loss function which returns a zero-dimensional
		array, pass ``None`` to ``gy_data``. In this case, it sets ``1`` to
		``grad`` attribute of the result::
		>>   check_backward(my_loss_func, (x1_data, x2_data), None)
		If ``MyFunc`` returns multiple outputs, pass all gradients for outputs
		as a tuple::
		>>   gy1_data = xp.array(...)
		>>   gy2_data = xp.array(...)
		>>   check_backward(func, x1_data, (gy1_data, gy2_data))
		You can also test a :class:`~chainer.Link`.
		To check gradients of parameters of the link, set a tuple of the parameters
		to ``params`` arguments::
		>>   check_backward(my_link, (x1_data, x2_data), gy_data,
		>>                  (my_link.W, my_link.b))
		Note that ``params`` are not ``ndarray``\\ s,
		but :class:`~chainer.Variables`\\ s.
		Function objects are acceptable as ``func`` argument::
		>>   check_backward(lambda x1, x2: f(x1, x2),
		>>                  (x1_data, x2_data), gy_data)
		.. note::
		   ``func`` is called many times to get numerical gradients for all inputs.
		   This function doesn't work correctly when ``func`` behaves randomly as
		   it gets different gradients.
		Args:
			func (callable): A function which gets :class:`~chainer.Variable`\\ s
				and returns :class:`~chainer.Variable`\\ s. ``func`` must returns
				a tuple of :class:`~chainer.Variable`\\ s or one
				:class:`~chainer.Variable`. You can use a
				:class:`~chainer.Function`, :class:`~chainer.FunctionNode` or a
				:class:`~chainer.Link` object or any other function satisfying the
				condition.
			x_data (ndarray or tuple of ndarrays): A set of ``ndarray``\\ s to be
				passed to ``func``. If ``x_data`` is one ``ndarray`` object, it is
				treated as ``(x_data,)``.
			y_grad (ndarray or tuple of ndarrays or None):
				A set of ``ndarray``\\ s representing gradients of return-values of
				``func``. If ``y_grad`` is one ``ndarray`` object, it is
				treated as ``(y_grad,)``. If ``func`` is a loss-function,
				``y_grad`` should be set to ``None``.
			params (~chainer.Variable or tuple of ~chainder.Variable):
				A set of :class:`~chainer.Variable`\\ s whose gradients are
				checked. When ``func`` is a :class:`~chainer.Link` object,
				set its parameters as ``params``.
				If ``params`` is one :class:`~chainer.Variable` object,
				it is treated as ``(params,)``.
			eps (float): Epsilon value to be passed to :func:`numerical_grad`.
			atol (float): Absolute tolerance to be passed to
				:func:`chainer.testing.assert_allclose`.
			rtol (float): Relative tolerance to be passed to
				:func:`chainer.testing.assert_allclose`.
			no_grads (list of bool): Flag to skip variable for gradient assertion.
				It should be same length as ``x_data``.
			dtype (~numpy.dtype): ``x_data``, ``y_grad`` and ``params`` are casted
				to this dtype when calculating numerical gradients. Only float
				types and ``None`` are allowed.
		.. seealso::
		   :func:`numerical_grad`
	**/
	static public function check_backward(func:Dynamic, x_data:Dynamic, y_grad:Dynamic, ?params:Dynamic, ?eps:Dynamic, ?atol:Dynamic, ?rtol:Dynamic, ?no_grads:Dynamic, ?dtype:Dynamic) : Dynamic;
	/**
		Test twice differentiation of a given procedure.
		This function automatically checks if the backward procedure of ``func``
		is correctly implemented for further differentiation. It first computes the
		gradient of ``func`` w.r.t. its inputs in the same way as
		:func:`~chainer.gradient_check.check_backward`. This function then further
		invokes the backward procedure against the gradient variables, starting
		from the initial gradient given by ``x_grad_grad``. It also computes the
		second gradient using :func:`~chainer.gradient_check.numerical_grad`. The
		resulting gradients are compared to confirm if the second-order gradients
		are approximately correct.
		Note that this function **DOES NOT** check if the first-order
		differentiation is correct; the numerical gradient assumes that the
		first-order gradient given by the usual :meth:`chainer.Variable.backward`
		is correct. The implementation of each differentiable function should be
		tested by :func:`~chainer.gradient_check.check_backward` first, and then
		should be tested by this function if neccessary.
		For the details of the arguments, see
		:func:`~chainer.gradient_check.check_backward`. The additional arguments
		``x_grad_grad`` and ``params_grad_grad`` are (tuples of)
		:class:`~chainer.Variable` (s) that include the initial gradient
		corresponding to the first-order gradient of each input and parameter. Note
		that the default error tolerance ``atol`` and ``rtol`` are slightly larger
		than those of :func:`~chainer.gradient_check.check_backward` because the
		numerical gradients of the second order differentiation are less accurate
		than those of the first order gradients.
	**/
	static public function check_double_backward(func:Dynamic, x_data:Dynamic, y_grad:Dynamic, x_grad_grad:Dynamic, ?params:Dynamic, ?params_grad_grad:Dynamic, ?eps:Dynamic, ?atol:Dynamic, ?rtol:Dynamic, ?no_grads:Dynamic, ?dtype:Dynamic) : Dynamic;
	/**
		Computes numerical gradient by finite differences.
		This function is used to implement gradient check. For usage example, see
		unit tests of :mod:`chainer.functions`.
		Args:
			f (function): Python function with no arguments that runs forward
				computation and returns the result.
			inputs (tuple of arrays): Tuple of arrays that should be treated as
				inputs. Each element of them is slightly modified to realize
				numerical gradient by finite differences.
			grad_outputs (tuple of arrays): Tuple of arrays that are treated as
				output gradients.
			eps (float): Epsilon value of finite differences.
		Returns:
			tuple: Numerical gradient arrays corresponding to ``inputs``.
	**/
	static public function numerical_grad(f:Dynamic, inputs:Dynamic, grad_outputs:Dynamic, ?eps:Dynamic) : Dynamic;
}