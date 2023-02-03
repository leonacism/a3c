package chainer._function;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.function') extern class Function_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Make a context manager which enables back-propagation.

		When you want to enable back-propagation in :func:`no_backprop_mode`, call
		this method. A :class:`~chainer.Variable` created in this context always
		has a computational graph unless overridden by deeper contexts. If you call
		this method outside of :func:`no_backprop_mode` context, it changes
		nothing.

		In the following example, ``y`` has a computational graph and calling
		:func:`~chainer.Variable.backward` on ``y`` will compute and accumulate the
		gradients of the variables in the graph, in this case only ``x``.

		>>> x = chainer.Variable(np.array([1,], 'f'))
		>>> with chainer.no_backprop_mode():
		...     with chainer.force_backprop_mode():
		...         y = x + 1
		>>> y.backward()
		>>> x.grad
		array([1.], dtype=float32)

		.. seealso::

		   See :func:`no_backprop_mode` for details on disabled back-propagation
		   mode.
	**/
	static public function force_backprop_mode() : Dynamic;
	/**
		Make a context manager which disables back-propagation.

		In this context, Chainer does not make a computational graph. It has the
		benefit of reducing memory consumption. However, a
		:class:`~chainer.Variable` created in this context does not hold a
		reference to the :class:`~chainer.FunctionNode` that created itself so no
		gradients are accumulated by :func:`~chainer.Variable.backward`.

		In the following example, ``y`` is created in this context, which means
		that calling :func:`~chainer.Variable.backward` on ``y`` has no effect on
		the gradients of ``x``.

		>>> x = chainer.Variable(np.array([1,], 'f'))
		>>> with chainer.no_backprop_mode():
		...     y = x + 1
		>>> y.backward()
		>>> x.grad is None
		True

		.. seealso::

		   See :func:`force_backprop_mode` for details on how to override this
		   context.
	**/
	static public function no_backprop_mode() : Dynamic;
}