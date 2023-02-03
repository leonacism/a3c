package chainer.testing.unary_math_function_test;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.testing.unary_math_function_test') extern class Unary_Math_Function_Test_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _error : Dynamic;
	static public function _func_class(func:Dynamic) : Dynamic;
	static public function _func_name(func:Dynamic) : Dynamic;
	static public function _make_data_default(shape:Dynamic, dtype:Dynamic) : Dynamic;
	static public function _nonlinear(func:Dynamic) : Dynamic;
	static public function check_available() : Dynamic;
	static public function is_available() : Dynamic;
	/**
		Decorator for testing unary mathematical Chainer functions.
		This decorator makes test classes test unary mathematical Chainer
		functions. Tested are forward and backward, including double backward,
		computations on CPU and GPU across parameterized ``shape`` and ``dtype``.
		Args:
			func(function or ~chainer.Function): Chainer function to be tested by
				the decorated test class. Taking :class:`~chainer.Function` is for
				backward compatibility.
			func_expected: Function used to provide expected values for
				testing forward computation. If not given, a corresponsing numpy
				function for ``func`` is implicitly picked up by its name.
			label_expected(string): String used to test labels of Chainer
				functions. If not given, the name of ``func`` is implicitly used.
			make_data: Function to customize input and gradient data used
				in the tests. It takes ``shape`` and ``dtype`` as its arguments,
				and returns a tuple of input, gradient and double gradient data. By
				default, uniform destribution ranged ``[-1, 1]`` is used for all of
				them.
			is_linear(bool): Tells the decorator that ``func`` is a linear function
				so that it wraps ``func`` as a non-linear function to perform
				double backward test. The default value is ``False``.
			forward_options(dict): Options to be specified as an argument of
				:func:`chainer.testing.assert_allclose` function.
				If not given, preset tolerance values are automatically selected.
			backward_options(dict): Options to be specified as an argument of
				:func:`chainer.gradient_check.check_backward` function.
				If not given, preset tolerance values are automatically selected
				depending on ``dtype``.
			double_backward_options(dict): Options to be specified as an argument
				of :func:`chainer.gradient_check.check_double_backward` function.
				If not given, preset tolerance values are automatically selected
				depending on ``dtype``.
		The decorated test class tests forward, backward and double backward
		computations on CPU and GPU across the following
		:func:`~chainer.testing.parameterize` ed parameters:
		- shape: rank of zero, and rank of more than zero
		- dtype: ``numpy.float16``, ``numpy.float32`` and ``numpy.float64``
		Additionally, it tests the label of the Chainer function.
		Chainer functions tested by the test class decorated with the decorator
		should have the following properties:
		- Unary, taking one parameter and returning one value
		- ``dtype`` of input and output are the same
		- Elementwise operation for the supplied ndarray
		.. admonition:: Example
		   The following code defines a test class that tests
		   :func:`~chainer.functions.sin` Chainer function, which takes a parameter
		   with ``dtype`` of float and returns a value with the same ``dtype``.
		   .. doctest::
			  >>> import unittest
			  >>> from chainer import testing
			  >>> from chainer import functions as F
			  >>>
			  >>> @testing.unary_math_function_unittest(F.sin)
			  ... class TestSin(unittest.TestCase):
			  ...     pass
		   Because the test methods are implicitly injected to ``TestSin`` class by
		   the decorator, it is enough to place ``pass`` in the class definition.
		   To customize test data, ``make_data`` optional parameter can be used.
		   The following is an example of testing ``sqrt`` Chainer function, which
		   is tested in positive value domain here instead of the default input.
		   .. doctest::
			  >>> import numpy
			  >>>
			  >>> def make_data(shape, dtype):
			  ...     x = numpy.random.uniform(0.1, 1, shape).astype(dtype)
			  ...     gy = numpy.random.uniform(-1, 1, shape).astype(dtype)
			  ...     ggx = numpy.random.uniform(-1, 1, shape).astype(dtype)
			  ...     return x, gy, ggx
			  ...
			  >>> @testing.unary_math_function_unittest(F.sqrt,
			  ...                                       make_data=make_data)
			  ... class TestSqrt(unittest.TestCase):
			  ...     pass
		   ``make_data`` function which returns input, gradient and double gradient
		   data generated in proper value domains with given ``shape`` and
		   ``dtype`` parameters is defined, then passed to the decorator's
		   ``make_data`` parameter.
	**/
	static public function unary_math_function_unittest(func:Dynamic, ?func_expected:Dynamic, ?label_expected:Dynamic, ?make_data:Dynamic, ?is_linear:Dynamic, ?forward_options:Dynamic, ?backward_options:Dynamic, ?double_backward_options:Dynamic) : Dynamic;
}