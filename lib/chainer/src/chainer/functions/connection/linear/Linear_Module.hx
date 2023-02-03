package chainer.functions.connection.linear;

/**
 * ...
 * @author 
 */
@:pythonImport('chainer.functions.connection.linear') extern class Linear_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Linear function, or affine transformation.
		It accepts two or three arguments: an input minibatch ``x``, a weight
		matrix ``W``, and optionally a bias vector ``b``. It computes
		.. math:: Y = xW^\\top + b.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`): Input variable, which is a :math:`(s_B, s_1, \
				s_2, ..., s_n)`-shaped float array. Its first dimension
				:math:`(s_B)` is assumed to be the *minibatch dimension*. The
				other dimensions are treated as concatenated one dimension whose
				size must be :math:`(s_1 * ... * s_n = N)`.
			W (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`): Weight variable of shape :math:`(M, N)`,
				where :math:`(N = s_1 * ... * s_n)`.
			b (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`): Bias variable (optional) of shape
				:math:`(M,)`.
		Returns:
			~chainer.Variable: Output variable. A float array with shape
			of :math:`(s_B, M)`.
		.. seealso:: :class:`~chainer.links.Linear`
		.. admonition:: Example
			>>> x = np.random.uniform(0, 1, (3, 4)).astype('f')
			>>> W = np.random.uniform(0, 1, (5, 4)).astype('f')
			>>> b = np.random.uniform(0, 1, (5,)).astype('f')
			>>> y = F.linear(x, W, b)
			>>> y.shape
			(3, 5)
	**/
	static public function linear(x:Dynamic, W:Dynamic, ?b:Dynamic) : Dynamic;
}