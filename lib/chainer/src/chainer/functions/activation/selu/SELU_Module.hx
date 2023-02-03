package chainer.functions.activation.selu;

/**
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.selu') extern class SELU_Module = {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Scaled Exponential Linear Unit function.
		For parameters :math:`\\alpha` and :math:`\\lambda`, it is expressed as
		.. math::
			f(x) = \\lambda \\left \\{ \\begin{array}{ll}
			x & {\\rm if}~ x \\ge 0 \\\\
			\\alpha (\\exp(x) - 1) & {\\rm if}~ x < 0,
			\\end{array} \\right.
		See: https://arxiv.org/abs/1706.02515
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			alpha (float): Parameter :math:`\\alpha`.
			scale (float): Parameter :math:`\\lambda`.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
	**/
	static public function selu(x:Dynamic, ?alpha:Dynamic, ?scale:Dynamic) : Dynamic;
}