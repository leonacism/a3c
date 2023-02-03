package chainer.functions.activation.hard_sigmoid;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.hard_sigmoid') extern class Hard_Sigmoid_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Element-wise hard-sigmoid function.
		This function is defined as
		.. math::
			f(x) = \\left \\{ \\begin{array}{ll}
			0 & {\\rm if}~ x < -2.5 \\\\
			0.2 x + 0.5 & {\\rm if}~ -2.5 < x < 2.5 \\\\
			1 & {\\rm if}~ 2.5 < x.
			\\end{array} \\right.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			It maps the input values into the range of :math:`[0, 1]`.
			>>> x = np.array([-2.6, -1, 0, 1, 2.6])
			>>> x
			array([-2.6, -1. ,  0. ,  1. ,  2.6])
			>>> F.hard_sigmoid(x).data
			array([0. , 0.3, 0.5, 0.7, 1. ])
	**/
	static public function hard_sigmoid(x:Dynamic) : Dynamic;
}