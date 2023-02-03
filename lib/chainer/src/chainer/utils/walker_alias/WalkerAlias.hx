package chainer.utils.walker_alias;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.utils.walker_alias', 'WalkerAlias') extern class WalkerAlias {
	/**
		Implementation of Walker's alias method.
		This method generates a random sample from given probabilities
		:math:`p_1, \\dots, p_n` in :math:`O(1)` time.
		It is more efficient than :func:`~numpy.random.choice`.
		This class works on both CPU and GPU.
		Args:
			probs (float list): Probabilities of entries. They are normalized with
								`sum(probs)`.
		See: `Wikipedia article <https://en.wikipedia.org/wiki/Alias_method>`_
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
	public function ___init__(probs:Dynamic):Dynamic;
	public function __init_subclass__() : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(probs:Dynamic):Void;
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
		Generates a random sample based on given probabilities.
        Args:
            shape (tuple of int): Shape of a return value.
        Returns:
            Returns a generated array with the given shape. If a sampler is in
            CPU mode the return value is a :class:`numpy.ndarray` object, and
            if it is in GPU mode the return value is a :class:`cupy.ndarray`
            object.
	**/
	public function sample() : Dynamic;
	/**
		
	**/
	public function sample_cpu() : Dynamic;
	/**
		
	**/
	public function sample_gpu() : Dynamic;
	/**
		Make a sampler CPU mode.
	**/
	public function to_cpu() : Dynamic;
	/**
		Make a sampler GPU mode.
	**/
	public function to_gpu() : Dynamic;
}