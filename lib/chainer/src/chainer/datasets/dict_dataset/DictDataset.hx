package chainer.datasets.dict_dataset;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.datasets.dict_dataset', 'DictDataset') extern class DictDataset {
	/**
		Dataset of a dictionary of datasets.

		It combines multiple datasets into one dataset. Each example is represented
		by a dictionary mapping a key to an example of the corresponding dataset.

		Args:
			datasets: Underlying datasets. The keys are used as the keys of each
				example. All datasets must have the same length.
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
		Returns an example or a sequence of examples.

        It implements the standard Python indexing and one-dimensional integer
        array indexing. It uses the :meth:`get_example` method by default, but
        it may be overridden by the implementation to, for example, improve the
        slicing performance.

        Args:
            index (int, slice, list or numpy.ndarray): An index of an example
                or indexes of examples.

        Returns:
            If index is int, returns an example created by `get_example`.
            If index is either slice or one-dimensional list or numpy.ndarray,
            returns a list of examples created by `get_example`.

        .. admonition:: Example

           >>> import numpy
           >>> from chainer import dataset
           >>> class SimpleDataset(dataset.DatasetMixin):
           ...     def __init__(self, values):
           ...         self.values = values
           ...     def __len__(self):
           ...         return len(self.values)
           ...     def get_example(self, i):
           ...         return self.values[i]
           ...
           >>> ds = SimpleDataset([0, 1, 2, 3, 4, 5])
           >>> ds[1]   # Access by int
           1
           >>> ds[1:3]  # Access by slice
           [1, 2]
           >>> ds[[4, 0]]  # Access by one-dimensional integer list
           [4, 0]
           >>> index = numpy.arange(3)
           >>> ds[index]  # Access by one-dimensional integer numpy.ndarray
           [0, 1, 2]
	**/
	public function __getitem__(index:Dynamic) : Dynamic;
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
	public function ___init__(?datasets:python.KwArgs<Dynamic>):Dynamic;
	public function __init_subclass__() : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(?datasets:python.KwArgs<Dynamic>):Void;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	/**
		Returns the number of data points.
	**/
	public function __len__() : Dynamic;
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
}