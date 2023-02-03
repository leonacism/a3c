package chainer.functions.array.concat;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.array.concat') extern class Concat_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Concatenates given variables along an axis.
		Args:
			xs (tuple of :class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variables to be concatenated. The variables must have the \
				same shape, except in the dimension corresponding to axis.
			axis (int): The axis along which the arrays will be joined. Default \
				is 1.
		Returns:
			~chainer.Variable: The concatenated variable.
		.. admonition:: Example
			>>> x = np.arange(0, 12).reshape(3, 4)
			>>> x
			array([[ 0,  1,  2,  3],
				   [ 4,  5,  6,  7],
				   [ 8,  9, 10, 11]])
			>>> y = np.arange(0, 3).reshape(3, 1)
			>>> y
			array([[0],
				   [1],
				   [2]])
			>>> z = F.concat((x, y), axis=1)
			>>> z.data
			array([[ 0,  1,  2,  3,  0],
				   [ 4,  5,  6,  7,  1],
				   [ 8,  9, 10, 11,  2]])
	**/
	static public function concat(xs:Dynamic, ?axis:Dynamic) : Dynamic;
}