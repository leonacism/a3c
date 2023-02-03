package chainer.functions.activation.softmax;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.softmax') extern class Softmax_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _get_tensor4d_shape(axis:Dynamic, shape:Dynamic) : Dynamic;
	/**
		Softmax function.
		This function computes its softmax along an axis. Let
		:math:`c = (c_1, c_2, \\dots, c_D)` be the slice of ``x`` along with
		the axis. For each slice :math:`c`, it computes the function :math:`f(c)`
		defined as :math:`f(c)={\\exp(c) \\over \\sum_{d} \\exp(c_d)}`.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable.
				A :math:`n`-dimensional (:math:`n \\geq 2`) float array.
			axis (int): The axis along which the softmax is to be computed.
		Returns:
			~chainer.Variable: Output variable.
			A :math:`n`-dimensional (:math:`n \\geq 2`) float array, which is the
			same shape with x.
		.. admonition:: Example
			>>> x = np.array([[0, 1, 2], [0, 2, 4]], 'f')
			>>> x
			array([[0., 1., 2.],
				   [0., 2., 4.]], dtype=float32)
			>>> y = F.softmax(x, axis=1)
			>>> y.data
			array([[0.09003057, 0.24472848, 0.66524094],
				   [0.01587624, 0.11731043, 0.86681336]], dtype=float32)
			>>> F.sum(y, axis=1).data
			array([1., 1.], dtype=float32)
	**/
	static public function softmax(x:Dynamic, ?axis:Dynamic) : Dynamic;
}