package chainer.functions.activation.prelu;

/**
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.prelu') extern class PReLU_Module = {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _fwd_kern() : Dynamic;
	static public function _get_extended_shape(W:Dynamic, x:Dynamic) : Dynamic;
	static public function _get_reduce_axes(W:Dynamic, x:Dynamic) : Dynamic;
	/**
		Parametric ReLU function.
		It accepts two arguments: an input ``x`` and a weight array ``W``
		and computes the output as :math:`PReLU(x) = \\max(x, W*x)`,
		where :math:`*` is an elementwise multiplication for each sample in the
		batch.
		When the PReLU function is combined with two-dimensional convolution, the
		elements of parameter :math:`W` are typically shared across the same filter
		of different pixels. In order to support such usage, this function supports
		the shape of parameter array that indicates leading dimensions of input
		arrays except the batch dimension.
		For example, if :math:`W` has the shape of :math:`(2, 3, 4)`,
		:math:`x` must have the shape of :math:`(B, 2, 3, 4, S_1, ..., S_N)`
		where :math:`B` is the batch size and the number of trailing :math:`S`'s
		:math:`N` is an arbitrary non-negative integer.
		Args:
			x (~chainer.Variable): Input variable.
				Its first argument is assumed to be the minibatch dimension.
			W (~chainer.Variable): Weight variable.
		Returns:
			~chainer.Variable: Output variable
		.. seealso:: :class:`~chainer.links.PReLU`
	**/
	static public function prelu(x:Dynamic, W:Dynamic) : Dynamic;
}