package chainer.utils.type_check;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.utils.type_check', 'GetAttr') extern class GetAttr {
	static public function __add__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __and__(x:Dynamic, y:Dynamic) : Dynamic;
	public function __bool__() : Dynamic;
	public function __call__(?args:python.VarArgs<Dynamic>) : Dynamic;
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
	static public function __div__(x:Dynamic, y:Dynamic) : Dynamic;
	static public var __doc__ : Dynamic;
	/**
		Return self==value.
	**/
	public function __eq__(value:Dynamic) : Dynamic;
	/**
		default object formatter
	**/
	static public function __floordiv__(x:Dynamic, y:Dynamic) : Dynamic;
	public function __format__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return self>=value.
	**/
	public function __ge__(value:Dynamic):Dynamic;
	/**
		Return getattr(self, name).
	**/
	public function __getattr__(name:Dynamic):Dynamic;
	/**
		Return getattr(self, name).
	**/
	public function __getattribute__(name:Dynamic):Dynamic;
	public function __getitem__(key:Dynamic) : Dynamic;
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
	public function ___init__(obj:Dynamic, name:Dynamic):Dynamic;
	public function __init_subclass__() : Dynamic;
	static public function __invert__(x:Dynamic) : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(obj:Dynamic, name:Dynamic):Void;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	static public function __lshift__(x:Dynamic, y:Dynamic) : Dynamic;
	/**
		Return self<value.
	**/
	public function __lt__(value:Dynamic):Dynamic;
	static public function __mod__(x:Dynamic, y:Dynamic) : Dynamic;
	static public var __module__ : Dynamic;
	static public function __mul__(x:Dynamic, y:Dynamic) : Dynamic;
	/**
		Return self!=value.
	**/
	public function __ne__(value:Dynamic):Dynamic;
	static public function __neg__(x:Dynamic) : Dynamic;
	/**
		Create and return a new object.  See help(type) for accurate signature.
	**/
	static public function __new__(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	public function __nonzero__() : Dynamic;
	static public function __or__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __pos__(x:Dynamic) : Dynamic;
	static public function __pow__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __radd__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rand__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rdiv__(x:Dynamic, y:Dynamic) : Dynamic;
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
	static public function __rfloordiv__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rlshift__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rmod__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rmul__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __ror__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rrshift__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rshift__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rsub__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rtruediv__(x:Dynamic, y:Dynamic) : Dynamic;
	static public function __rxor__(x:Dynamic, y:Dynamic) : Dynamic;
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
	static public function __sub__(x:Dynamic, y:Dynamic) : Dynamic;
	/**
		Abstract classes can override this to customize issubclass().
		
		This is invoked early on by abc.ABCMeta.__subclasscheck__().
		It should return True, False or NotImplemented.  If it returns
		NotImplemented, the normal algorithm is used.  Otherwise, it
		overrides the normal algorithm (and the outcome is cached).
	**/
	static public function __subclasshook__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	static public function __truediv__(x:Dynamic, y:Dynamic) : Dynamic;
	/**
		list of weak references to the object (if defined)
	**/
	public var __weakref__ : Dynamic;
	static public function __xor__(x:Dynamic, y:Dynamic) : Dynamic;
	/**
		Evaluates the tree to get actual value.
        Behavior of this function depends on an implementation class.
        For example, a binary operator ``+`` calls the ``__add__`` function
        with the two results of :meth:`eval` function.
	**/
	public function eval() : Dynamic;
}