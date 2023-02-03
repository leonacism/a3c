package chainer.datasets.sub_dataset;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.datasets.sub_dataset', 'SubDataset') extern class SubDataset {
	/**
		Subset of a base dataset.

		SubDataset defines a subset of a given base dataset. The subset is defined
		as an interval of indexes, optionally with a given permutation.

		If ``order`` is given, then the ``i``-th example of this dataset is the
		``order[start + i]``-th example of the base dataset, where ``i`` is a
		non-negative integer. If ``order`` is not given, then the ``i``-th example
		of this dataset is the ``start + i``-th example of the base dataset.
		Negative indexing is also allowed: in this case, the term ``start + i`` is
		replaced by ``finish + i``.

		SubDataset is often used to split a dataset into training and validation
		subsets. The training set is used for training, while the validation set is
		used to track the generalization performance, i.e. how the learned model
		works well on unseen data. We can tune hyperparameters (e.g. number of
		hidden units, weight initializers, learning rate, etc.) by comparing the
		validation performance. Note that we often use another set called test set
		to measure the quality of the tuned hyperparameter, which can be made by
		nesting multiple SubDatasets.

		There are two ways to make training-validation splits. One is a single
		split, where the dataset is split just into two subsets. It can be done by
		:func:`split_dataset` or :func:`split_dataset_random`. The other one is a
		:math:`k`-fold cross validation, in which the dataset is divided into
		:math:`k` subsets, and :math:`k` different splits are generated using each
		of the :math:`k` subsets as a validation set and the rest as a training
		set. It can be done by :func:`get_cross_validation_datasets`.

		Args:
			dataset: Base dataset.
			start (int): The first index in the interval.
			finish (int): The next-to-the-last index in the interval.
			order (sequence of ints): Permutation of indexes in the base dataset.
				If this is ``None``, then the ascending order of indexes is used.
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
	public function ___init__(dataset:Dynamic, start:Dynamic, finish:Dynamic, ?order:Dynamic) : Dynamic;
	public function __init_subclass__() : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(dataset:Dynamic, start:Dynamic, finish:Dynamic, ?order:Dynamic) : Void;
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
	/**
		Returns the i-th example.

        Implementations should override it. It should raise :class:`IndexError`
        if the index is invalid.

        Args:
            i (int): The index of the example.

        Returns:
            The i-th example.
	**/
	public function get_example(i:Dynamic) : Dynamic;
}