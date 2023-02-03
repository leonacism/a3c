package chainer.serializer;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.serializer', 'Deserializer') extern class Deserializer {
	/*
		Base class of all deserializers.
	**/

	/**
		Serializes or deserializes a value by given name.
        This operator saves or loads a value by given name.
        If this is a serializer, then the value is simply saved at the key.
        Note that some type information might be missed depending on the
        implementation (and the target file format).
        If this is a deserializer, then the value is loaded by the key. The
        deserialization differently works on scalars and arrays. For scalars,
        the ``value`` argument is used just for determining the type of
        restored value to be converted, and the converted value is returned.
        For arrays, the restored elements are directly copied into the
        ``value`` argument. String values are treated like scalars.
        .. note::
           As of v2.0.0, serializers and deserializers are required to
           correctly handle the ``None`` value. When ``value`` is ``None``,
           serializers save it in format-dependent ways, and deserializers
           just return the loaded value. When the saved ``None`` value is
           loaded by a deserializer, it should quietly return the ``None``
           value without modifying the ``value`` object.
        Args:
            key (str): Name of the serialization entry.
            value (scalar, numpy.ndarray, cupy.ndarray, None, or str):
                Object to be (de)serialized.
                ``None`` is only supported by deserializers.
        Returns:
            Serialized or deserialized value.
	**/
	public function __call__(key:Dynamic, value:Dynamic):Dynamic;
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
	/*
		Gets a child serializer.
        This operator creates a _child_ serializer represented by the given
        key.
        Args:
            key (str): Name of the child serializer.
	**/
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
	public function ___init__() : Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new() : Void;
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
	/*
		Loads an object from this deserializer.
        This is equivalent to ``obj.serialize(self)``.
        Args:
            obj: Target object to be serialized.
	**/
	public function load(obj:Dynamic) : Dynamic;
}