package chainer.functions.activation.elu;

/**
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.elu') extern class ELU_Module = {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Exponential Linear Unit function.
		For a parameter :math:`\\alpha`, it is expressed as
		.. math::
			f(x) = \\left \\{ \\begin{array}{ll}
			x & {\\rm if}~ x \\ge 0 \\\\
			\\alpha (\\exp(x) - 1) & {\\rm if}~ x < 0,
			\\end{array} \\right.
		See: https://arxiv.org/abs/1511.07289
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			alpha (float): Parameter :math:`\\alpha`. Default is 1.0.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.array([[-1, 0], [2, -3]], 'f')
			>>> x
			array([[-1.,  0.],
				   [ 2., -3.]], dtype=float32)
			>>> y = F.elu(x, alpha=1.)
			>>> y.data
			array([[-0.63212055,  0.        ],
				   [ 2.        , -0.95021296]], dtype=float32)
	**/
	static public function elu(x:Dynamic, ?alpha:Dynamic) : Dynamic;
}