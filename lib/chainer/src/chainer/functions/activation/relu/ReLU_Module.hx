package chainer.functions.activation.relu;

/**
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.relu') extern class ReLU_Module = {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _heaviside(x:Dynamic) : Dynamic;
	/**
		Rectified Linear Unit function.
		.. math:: f(x)=\\max(0, x).
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.array([[-1, 0], [2, -3], [-2, 1]], 'f')
			>>> np.any(x < 0)
			True
			>>> y = F.relu(x)
			>>> np.any(y.data < 0)
			False
			>>> y.shape
			(3, 2)
	**/
	static public function relu(x:Dynamic) : Dynamic;
}