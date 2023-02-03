package chainer.functions.array.select_item;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.array.select_item') extern class Select_Item_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Select elements stored in given indices.
		This function returns ``t.choose(x.T)``, that means
		``y[i] == x[i, t[i]]`` for all ``i``.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable storing arrays. A two-dimensional float array.
			t (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable storing index numbers. A one-dimensional int array.
				Length of the ``t`` should be equal to ``x.shape[0]``.
		Returns:
			~chainer.Variable: Variable that holds ``t``-th element of ``x``.
		.. admonition:: Example
			>>> x = np.array([[0, 1, 2], [3, 4, 5]], np.float32)
			>>> t = np.array([0, 2], np.int32)
			>>> y = F.select_item(x, t)
			>>> y.shape
			(2,)
			>>> y.data
			array([0., 5.], dtype=float32)
	**/
	static public function select_item(x:Dynamic, t:Dynamic) : Dynamic;
}