package chainer._function;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.function', 'FunctionAdapter') extern class FunctionAdapter {
	/**
		Adapter class to wrap Function with FunctionNode.

		While :class:`~chainer.FunctionNode` provides the interface
		of new-style differentiable functions, the old-style
		:class:`~chainer.Function` can still be used for the backward
		compatibility.
		This class provides an adapter of there interface; it adds
		:class:`~chainer.FunctionNode` interface to any
		:class:`~chainer.Function` object by delegation.

		.. note::

		   The ownership of :class:`FunctionAdapter` and :class:`~chainer.Function`
		   is a bit tricky.
		   At the initialization, :class:`FunctionAdapter` is owned by the
		   :class:`~chainer.Function` object.
		   Once the function is applied to variables, the ownership is reversed;
		   the adapter becomes the owner of the
		   :class:`~chainer.Function` object and the :class:`~chainer.Function`
		   object changes the reference to a weak one.

		Args:
			function (Function): The function object to wrap.

		.. versionadded:: 3.0.0
	**/

	public function __call__(?inputs:python.VarArgs<Dynamic>):Dynamic;
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
	/**
		Return self==value.
	**/
	public function __eq__(value:Dynamic) : Dynamic;
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
	public function ___init__(_function:Dynamic):Dynamic;
	public function __init_subclass__() : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(_function:Dynamic):Void;
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
	
	@:native('_function') static public var __function : Dynamic;
	static public var _weak_function : Dynamic;
	/**
		
	**/
	public function check_type_forward(in_types:Dynamic) : Dynamic;
	/**
		
	**/
	public function forward(inputs:Dynamic) : Dynamic;
	/**
		
	**/
	public function backward(inputs:Dynamic, grad_outputs:Dynamic) : Dynamic;
	/**
		The :class:`Function` object that this adapter is wrapping.
	**/
	@:native('function') public var _function : Dynamic;
	/**
		
	**/
	public var label : Dynamic;
	public var _impl_name : Dynamic;
}