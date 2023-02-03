package chainer.functions.activation.crelu;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.crelu') extern class CReLU_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Concatenated Rectified Linear Unit function.
		This function is expressed as follows
		 .. math:: f(x) = (\\max(0, x), \\max(0, -x)).
		Here, two output values are concatenated along an axis.
		See: https://arxiv.org/abs/1603.05201
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			axis (int): Axis that the output values are concatenated along.
				Default is 1.
		Returns:
			~chainer.Variable: Output variable of concatenated array.
			If the axis is 1, A :math:`(s_1, s_2 \\times 2, ..., s_N)`-shaped float
			array.
		.. admonition:: Example
			>>> x = np.array([[-1, 0], [2, -3]], 'f')
			>>> x
			array([[-1.,  0.],
				   [ 2., -3.]], dtype=float32)
			>>> y = F.crelu(x, axis=1)
			>>> y.data
			array([[0., 0., 1., 0.],
				   [2., 0., 0., 3.]], dtype=float32)
	**/
	static public function crelu(x:Dynamic, ?axis:Dynamic) : Dynamic;
}