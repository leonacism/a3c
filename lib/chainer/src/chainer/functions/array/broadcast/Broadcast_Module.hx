package chainer.functions.array.broadcast;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.array.broadcast') extern class Broadcast_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _backward_one(g:Dynamic, shape:Dynamic) : Dynamic;
	/**
		Broadcast given variables.
		Args:
			args (:class:`~chainer.Variable` or :class:`numpy.ndarray` \
			or :class:`cupy.ndarray`):
				Input variables to be broadcasted. Each dimension of the shapes \
				of the input variables must have the same size.
		Returns:
			~chainer.Variable: :class:`~chainer.Variable` or tuple of \
				:class:`~chainer.Variable` objects which are broadcasted \
				from given arguments.
		.. admonition:: Example
			>>> x = np.random.uniform(0, 1, (3, 2)).astype('f')
			>>> y = F.broadcast(x)
			>>> np.all(x == y.data)
			True
			>>> z = np.random.uniform(0, 1, (3, 2)).astype('f')
			>>> y, w = F.broadcast(x, z)
			>>> np.all(x == y.data) & np.all(z == w.data)
			True
	**/
	static public function broadcast(?args:python.VarArgs<Dynamic>) : Dynamic;
	/**
		Broadcast a given variable to a given shape.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable be broadcasted. A \
				:math:`(s_1, s_2, ..., s_N)`-shaped float array.
			shape (tuple): Tuple of :class:`int` of the shape of the \
				output variable.
		Returns:
			~chainer.Variable: Output variable broadcasted to the given shape.
		.. admonition:: Example
			>>> x = np.arange(0, 3)
			>>> x
			array([0, 1, 2])
			>>> y = F.broadcast_to(x, (3, 3))
			>>> y.data
			array([[0, 1, 2],
				   [0, 1, 2],
				   [0, 1, 2]])
	**/
	static public function broadcast_to(x:Dynamic, shape:Dynamic) : Dynamic;
}