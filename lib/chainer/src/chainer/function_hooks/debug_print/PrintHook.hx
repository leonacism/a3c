package chainer.function_hooks.debug_print;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.function_hooks.debug_print', 'PrintHook') extern class PrintHook {
	/**
		Function hook that prints debug information.

		This function hook outputs the debug information of input arguments of
		``forward`` and ``backward`` methods involved in the hooked functions
		at preprocessing time (that is, just before each method is called).

		Unlike simple "debug print" technique, where users insert print functions
		at every function to be inspected, we can show the information
		of all functions involved with single ``with`` statement.

		Further, this hook enables us to show the information of
		``backward`` methods without inserting print functions into
		Chainer's library code.

		Attributes:
			sep: Separator of print function.
			end: Character to be added at the end of print function.
			file: Output file_like object that that redirect to.
			flush: If ``True``, this hook forcibly flushes the text stream
				at the end of preprocessing.

		.. admonition:: Example

			The basic usage is to use it with ``with`` statement.

			>>> from chainer import function_hooks
			>>> l = L.Linear(10, 10)
			>>> x = chainer.Variable(np.zeros((1, 10), 'f'))
			>>> with chainer.function_hooks.PrintHook():
			...     y = l(x)
			...     z = F.sum(y)
			...     z.backward() # doctest:+SKIP

			In this example, ``PrintHook`` shows the debug information of
			forward propagation of ``LinearFunction`` (which is implicitly
			called by ``l``) and ``Sum`` (called by ``F.sum``)
			and backward propagation of ``z`` and ``y``.
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
	public function ___init__(?sep:Dynamic, ?end:Dynamic, ?file:Dynamic, ?flush:Dynamic) : Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(?sep:Dynamic, ?end:Dynamic, ?file:Dynamic, ?flush:Dynamic):Void;
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
	public function _print(msg:Dynamic) : Dynamic;
	public function _process(_function:Dynamic, in_data:Dynamic, ?out_grad:Dynamic) : Dynamic;
	/**
		Callback function invoked when a function hook is added

        Args:
            function(~chainer.FunctionNode): Function object to which
                the function hook is added.
	**/
	public function added(?_function:Dynamic) : Dynamic;
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
		Callback function invoked when a function hook is deleted

		Args:
			function(~chainer.FunctionNode): Function object to which
				the function hook is deleted.
	**/
	public function deleted(?_function:Dynamic) : Dynamic;
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
		Callback function invoked before forward propagation.

        Args:
            function(~chainer.FunctionNode): Function object to which
                the function hook is registered.
            in_data(tuple of numpy.ndarray or tuple of cupy.ndarray):
               Input data of forward propagation.
	**/
	public function forward_preprocess(_function:Dynamic, in_data:Dynamic) : Dynamic;
	static public var name : Dynamic;
}