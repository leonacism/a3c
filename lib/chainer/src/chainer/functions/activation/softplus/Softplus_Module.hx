package chainer.functions.activation.softplus;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.softplus') extern class Softplus_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Element-wise softplus function.
		The softplus function is the smooth approximation of ReLU.
		.. math:: f(x)=\\frac{1}{\\beta}\\log(1 + \\exp(\\beta x)),
		where :math:`\\beta` is a parameter. The function becomes curved
		and akin to ReLU as the :math:`\\beta` is increasing.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			beta (float): Parameter :math:`\\beta`.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.arange(-2, 3, 2).astype('f')
			>>> x
			array([-2.,  0.,  2.], dtype=float32)
			>>> F.softplus(x, beta=1.0).data
			array([0.126928 , 0.6931472, 2.126928 ], dtype=float32)
	**/
	static public function softplus(x:Dynamic, ?beta:Dynamic) : Dynamic;
}