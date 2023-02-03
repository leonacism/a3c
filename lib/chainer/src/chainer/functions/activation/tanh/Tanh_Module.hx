package chainer.functions.activation.tanh;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.tanh') extern class Tanh_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Elementwise hyperbolic tangent function.
		 .. math:: f(x)=\\tanh(x).
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.arange(-1, 4, 2).astype('f')
			>>> x
			array([-1.,  1.,  3.], dtype=float32)
			>>> F.tanh(x).data
			array([-0.7615942,  0.7615942,  0.9950548], dtype=float32)
	**/
	static public function tanh(x:Dynamic) : Dynamic;
}