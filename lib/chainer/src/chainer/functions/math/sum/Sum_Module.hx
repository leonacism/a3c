package chainer.functions.math.sum;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.math.sum') extern class Sum_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Sum of array elements over a given axis.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Elements to sum.
				A :math:`(s_1, s_2, ..., s_N)` -shaped float array.
			axis (None, int, or tuple of int): Axis along which a sum is performed.
				The default (axis = None) is perform a sum over all the dimensions
				of the input array.
			keepdims (bool): If ``True``, the specified axes are remained as axes
				of length one.
		Returns:
			~chainer.Variable: Output variable.
		.. admonition:: Example
			>>> x = np.arange(6).reshape(2,3).astype('f')
			>>> x
			array([[0., 1., 2.],
				   [3., 4., 5.]], dtype=float32)
			>>> y = F.sum(x)
			>>> y.shape
			()
			>>> y.data
			array(15., dtype=float32)
			>>> y = F.sum(x, axis=1)
			>>> y.shape
			(2,)
			>>> y.data
			array([ 3., 12.], dtype=float32)
			>>> y = F.sum(x, keepdims=True)
			>>> y.shape
			(1, 1)
			>>> y.data
			array([[15.]], dtype=float32)
	**/
	static public function sum(x:Dynamic, ?axis:Dynamic, ?keepdims:Dynamic) : Dynamic;
}