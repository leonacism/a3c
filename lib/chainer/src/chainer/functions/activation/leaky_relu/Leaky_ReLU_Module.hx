package chainer.functions.activation.leaky_relu;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.leaky_relu') extern class Leaky_ReLU_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _get_kern() : Dynamic;
	static public var _kern : Dynamic;
	/**
		Leaky Rectified Linear Unit function.
		This function is expressed as
		.. math::
			f(x) = \\left \\{ \\begin{array}{ll}
			x  & {\\rm if}~ x \\ge 0 \\\\
			ax & {\\rm if}~ x < 0,
			\\end{array} \\right.
		where :math:`a` is a configurable slope value.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			slope (float): Slope value :math:`a`.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.array([[-1, 0], [2, -3], [-2, 1]], 'f')
			>>> x
			array([[-1.,  0.],
				   [ 2., -3.],
				   [-2.,  1.]], dtype=float32)
			>>> F.leaky_relu(x, slope=0.2).data
			array([[-0.2,  0. ],
				   [ 2. , -0.6],
				   [-0.4,  1. ]], dtype=float32)
	**/
	static public function leaky_relu(x:Dynamic, ?slope:Dynamic) : Dynamic;
}