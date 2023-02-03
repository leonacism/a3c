package chainer.reporter;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.reporter', 'DictSummary') extern class DictSummary {
	/**
		Online summarization of a sequence of dictionaries.
		``DictSummary`` computes the statistics of a given set of scalars online.
		It only computes the statistics for scalar values and variables of scalar
		values in the dictionaries.
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
	/**
		Adds a dictionary of scalars.
        Args:
            d (dict): Dictionary of scalars to accumulate. Only elements of
               scalars, zero-dimensional arrays, and variables of
               zero-dimensional arrays are accumulated.
	**/
	public function add(value:Dynamic) : Dynamic;
	/**
		Creates a dictionary of mean values.
        It returns a single dictionary that holds a mean value for each entry
        added to the summary.
        Returns:
            dict: Dictionary of mean values.
	**/
	public function compute_mean() : Dynamic;
	/**
		Creates a dictionary of statistics.
        It returns a single dictionary that holds mean and standard deviation
        values for every entry added to the summary. For an entry of name
        ``'key'``, these values are added to the dictionary by names ``'key'``
        and ``'key.std'``, respectively.
        Returns:
            dict: Dictionary of statistics of all entries.
	**/
	public function make_statistics() : Dynamic;
	/**
		
	**/
	public function serialize(serializer:Dynamic) : Dynamic;
}