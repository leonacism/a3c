package chainer.functions.activation.sigmoid;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.sigmoid') extern class Sigmoid_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Element-wise sigmoid logistic function.
		 .. math:: f(x)=(1 + \\exp(-x))^{-1}.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			It maps the input values into the range of :math:`[0, 1]`.
			>>> x = np.arange(-2, 3, 2).astype('f')
			>>> x
			array([-2.,  0.,  2.], dtype=float32)
			>>> F.sigmoid(x)
			variable([0.11920291, 0.5       , 0.8807971 ])
	**/
	static public function sigmoid(x:Dynamic) : Dynamic;
}