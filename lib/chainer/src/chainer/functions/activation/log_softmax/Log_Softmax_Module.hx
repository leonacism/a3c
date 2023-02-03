package chainer.functions.activation.log_softmax;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.log_softmax') extern class Log_Softmax_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _log_softmax(x:Dynamic) : Dynamic;
	/**
		Channel-wise log-softmax function.
		This function computes its logarithm of softmax along the second axis.
		Let :math:`c = (c_1, c_2, \\dots, c_D)` be the slice of ``x`` along with
		the second axis. For each slice :math:`c`, it computes the logarithm of
		the function :math:`f(c)` defined as
		.. math::
			f(c) = {\\exp(c) \\over \\sum_{d} \\exp(c_d)}.
		This method is theoretically equivalent to ``log(softmax(x))`` but is more
		stable.
		.. note::
			``log(softmax(x))`` may cause underflow when ``x`` is too small,
			because ``softmax(x)`` may returns ``0``.
			``log_softmax`` method is more stable.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable.
				A :math:`n`-dimensional (:math:`n \\geq 2`) float array.
		Returns:
			~chainer.Variable: Output variable.
			A :math:`n`-dimensional (:math:`n \\geq 2`) float array, which is the
			same shape with x.
		.. seealso:: :func:`~chainer.functions.softmax`
		.. admonition:: Example
			>>> x = np.array([[0, 1, 2], [0, 2, 4]], 'f')
			>>> x
			array([[0., 1., 2.],
				   [0., 2., 4.]], dtype=float32)
			>>> F.log_softmax(x).data
			array([[-2.407606  , -1.4076059 , -0.4076059 ],
				   [-4.1429315 , -2.1429315 , -0.14293146]], dtype=float32)
			>>> np.allclose(F.log_softmax(x).data, F.log(F.softmax(x)).data)
			True
	**/
	static public function log_softmax(x:Dynamic) : Dynamic;
	static public function logsumexp(x:Dynamic) : Dynamic;
}