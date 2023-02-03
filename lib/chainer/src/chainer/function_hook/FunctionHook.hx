package chainer.function_hook;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.function_hook', 'FunctionHook') extern class FunctionHook {
	/**
		Base class of hooks for Functions.

		:class:`~chainer.FunctionHook` is a callback object
		that is registered to :class:`~chainer.FunctionNode`.
		Registered function hooks are invoked before and after
		forward and backward operations of each function.

		Function hooks that derive :class:`FunctionHook` are required
		to implement four methods:
		:meth:`~chainer.FunctionHook.forward_preprocess`,
		:meth:`~chainer.FunctionHook.forward_postprocess`,
		:meth:`~chainer.FunctionHook.backward_preprocess`, and
		:meth:`~chainer.FunctionHook.backward_postprocess`.
		By default, these methods do nothing.

		Specifically, when :meth:`~chainer.FunctionNode.__call__`
		method of some function is invoked,
		:meth:`~chainer.FunctionHook.forward_preprocess`
		(resp. :meth:`~chainer.FunctionHook.forward_postprocess`)
		of all function hooks registered to this function are called before
		(resp. after) forward propagation.

		Likewise, when :meth:`~chainer.Variable.backward` of some
		:class:`~chainer.Variable` is invoked,
		:meth:`~chainer.FunctionHook.backward_preprocess`
		(resp. :meth:`~chainer.FunctionHook.backward_postprocess`)
		of all function hooks registered to the function which holds this variable
		as a gradient are called before (resp. after) backward propagation.

		There are two ways to register :class:`~chainer.FunctionHook`
		objects to :class:`~chainer.FunctionNode` objects.

		First one is to use ``with`` statement. Function hooks hooked
		in this way are registered to all functions within ``with`` statement
		and are unregistered at the end of ``with`` statement.

		.. admonition:: Example

			The following code is a simple example in which
			we measure the elapsed time of a part of forward propagation procedure
			with :class:`~chainer.function_hooks.TimerHook`, which is a subclass of
			:class:`~chainer.FunctionHook`.

			>>> from chainer import function_hooks
			>>> class Model(chainer.Chain):
			...   def __init__(self):
			...     super(Model, self).__init__()
			...     with self.init_scope():
			...       self.l = L.Linear(10, 10)
			...   def __call__(self, x1):
			...     return F.exp(self.l(x1))
			>>> model1 = Model()
			>>> model2 = Model()
			>>> x = chainer.Variable(np.zeros((1, 10), 'f'))
			>>> with chainer.function_hooks.TimerHook() as m:
			...   _ = model1(x)
			...   y = model2(x)
			...   print("Total time : " + str(m.total_time()))
			...   model3 = Model()
			...   z = model3(y) # doctest:+ELLIPSIS
			Total time : ...

			In this example, we measure the elapsed times for each forward
			propagation of all functions in ``model1`` and ``model2``
			(specifically, :class:`~chainer.functions.LinearFunction` and
			:class:`~chainer.functions.Exp` of ``model1`` and ``model2``).
			Note that ``model3`` is not a target of measurement
			as :class:`~chainer.function_hooks.TimerHook` is unregistered
			before forward propagation of ``model3``.

		.. note::

		   Chainer stores the dictionary of registered function hooks
		   as a thread local object. So, function hooks registered
		   are different depending on threads.

		The other one is to register directly to
		:class:`~chainer.FunctionNode` object with
		:meth:`~chainer.Function.add_hook` method.
		Function hooks registered in this way can be removed by
		:meth:`~chainer.Function.delete_hook` method.
		Contrary to former registration method, function hooks are registered
		only to the function which :meth:`~chainer.FunctionNode.add_hook`
		is called.

		Args:
			name(str): Name of this function hook.
	**/

	static public function __class__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Implement delattr(self, name).
	**/
	public function __delattr__(name:Dynamic):Dynamic;
	static public var __dict__ : Dynamic;
	/**
		__dir__() -> list
		default dir() implementation
	**/
	public function __dir__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	static public var __doc__ : Dynamic;
	public function __enter__() : Dynamic;
	/**
		Return self==value.
	**/
	public function __eq__(value:Dynamic) : Dynamic;
	public function __exit__(?_:python.VarArgs<Dynamic>) : Dynamic;
	/**
		default object formatter
	**/
	public function __format__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return self>=value.
	**/
	public function __ge__(value:Dynamic):Dynamic;
	/**
		Return getattr(self, name).
	**/
	public function __getattribute__(name:Dynamic):Dynamic;
	/**
		Return self>value.
	**/
	public function __gt__(value:Dynamic):Dynamic;
	/**
		Return hash(self).
	**/
	public function __hash__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	@:native("__init__")
	public function ___init__():Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new():Void;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	/**
		Return self<value.
	**/
	public function __lt__(value:Dynamic):Dynamic;
	static public var __module__ : Dynamic;
	/**
		Return self!=value.
	**/
	public function __ne__(value:Dynamic):Dynamic;
	/**
		Create and return a new object.  See help(type) for accurate signature.
	**/
	static public function __new__(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		helper for pickle
	**/
	public function __reduce__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		helper for pickle
	**/
	public function __reduce_ex__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return repr(self).
	**/
	public function __repr__():Dynamic;
	/**
		Implement setattr(self, name, value).
	**/
	public function __setattr__(name:Dynamic, value:Dynamic):Dynamic;
	/**
		__sizeof__() -> int
		size of object in memory, in bytes
	**/
	public function __sizeof__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return str(self).
	**/
	public function __str__():Dynamic;
	/**
		Abstract classes can override this to customize issubclass().
		
		This is invoked early on by abc.ABCMeta.__subclasscheck__().
		It should return True, False or NotImplemented.  If it returns
		NotImplemented, the normal algorithm is used.  Otherwise, it
		overrides the normal algorithm (and the outcome is cached).
	**/
	static public function __subclasshook__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		list of weak references to the object (if defined)
	**/
	public var __weakref__ : Dynamic;
	static public var name : Dynamic;
	/**
		Callback function invoked when a function hook is added

        Args:
            function(~chainer.FunctionNode): Function object to which
                the function hook is added.
	**/
	public function added(?_function:Dynamic) : Dynamic;
	/**
		Callback function invoked when a function hook is deleted

        Args:
            function(~chainer.FunctionNode): Function object to which
                the function hook is deleted.
	**/
	public function deleted(?_function:Dynamic) : Dynamic;
	/**
		Callback function invoked before forward propagation.

        Args:
            function(~chainer.FunctionNode): Function object to which
                the function hook is registered.
            in_data(tuple of numpy.ndarray or tuple of cupy.ndarray):
               Input data of forward propagation.
	**/
	public function forward_preprocess(_function:Dynamic, in_data:Dynamic) : Dynamic;
	/**
		Callback function invoked after forward propagation.

        Args:
            function(~chainer.FunctionNode): Function object to which
                the function hook is registered.
            in_data(tuple of numpy.ndarray or tuple of cupy.ndarray):
                Input data of forward propagation.
	**/
	public function forward_postprocess(_function:Dynamic, in_data:Dynamic) : Dynamic;
	/**
		Callback function invoked before backward propagation.

        Args:
            function(~chainer.FunctionNode): Function object to which
                the function hook is registered.
            in_data(tuple of numpy.ndarray or tuple of cupy.ndarray):
                Input data of forward propagation.
            out_grad(tuple of numpy.ndarray or tuple of cupy.ndarray):
                Gradient data of backward propagation.
	**/
	public function backward_preprocess(_function:Dynamic, in_data:Dynamic, out_grad:Dynamic) : Dynamic;
	/**
		Callback function invoked after backward propagation.

        Args:
            function(~chainer.FunctionNode): Function object to which
                the function hook is registered.
            in_data(tuple of numpy.ndarray or tuple of cupy.ndarray):
                Input of forward propagation.
            out_grad(tuple of numpy.ndarray or tuple of cupy.ndarray):
                Gradient data of backward propagation.
	**/
	public function backward_postprocess(_function:Dynamic, in_data:Dynamic, out_grad:Dynamic) : Dynamic;
}