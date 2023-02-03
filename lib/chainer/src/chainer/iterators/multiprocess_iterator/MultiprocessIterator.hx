package chainer.iterators.multiprocess_iterator;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.iterators.multiprocess_iterator', 'MultiprocessIterator') extern class MultiprocessIterator {
	/**
		Dataset iterator that loads examples in parallel.
		This is an implementation of :class:`~chainer.dataset.Iterator` that loads
		examples with worker processes. It uses the standard :mod:`multiprocessing`
		module to parallelize the loading. The dataset is sent to the worker
		processes in the standard way using pickle.
		Note that this iterator effectively prefetches the examples for the next
		batch asynchronously after the current batch is returned.
		This iterator saves ``-1`` instead of ``None`` in snapshots since some
		serializers do not support ``None``.
		Args:
			dataset (~chainer.dataset.Dataset): Dataset to iterate.
			batch_size (int): Number of examples within each batch.
			repeat (bool): If ``True``, it infinitely loops over the dataset.
				Otherwise, it stops iteration at the end of the first epoch.
			shuffle (bool): If ``True``, the order of examples is shuffled at the
				beginning of each epoch. Otherwise, examples are extracted in the
				order of indexes.
			n_processes (int): Number of worker processes. The number of CPUs is
				used by default.
			n_prefetch (int): Number of prefetch batches.
			shared_mem (int): The size of using shared memory per data.
				If ``None``, size is adjusted automatically.
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
	public function ___init__(dataset:Dynamic, batch_size:Dynamic, ?repeat:Dynamic, ?shuffle:Dynamic, ?n_processes:Dynamic, ?n_prefetch:Dynamic, ?shared_mem:Dynamic) : Dynamic;
	/**
		Returns self.
	**/
	public function __iter__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(dataset:Dynamic, batch_size:Dynamic, ?repeat:Dynamic, ?shuffle:Dynamic, ?n_processes:Dynamic, ?n_prefetch:Dynamic, ?shared_mem:Dynamic):Void;
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
		Returns the next batch.

        This is a part of the iterator protocol of Python. It may raise the
        :class:`StopIteration` exception when it stops the iteration.
	**/
	public function __next__():Dynamic;
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
	static public var _comm : Dynamic
	static public var _finalized : Dynamic;
	static public var _interruption_testing : Dynamic;
	public function _set_prefetch_state() : Dynamic;
	static public var _thread : Dynamic;
	public var epoch_detail : Dynamic;
	/**
		Finalizes the iterator and possibly releases the resources.

        This method does nothing by default. Implementation may override it to
        better handle the internal resources.
	**/
	public function finalize() : Dynamic;
	/**
		Python2 alternative of ``__next__``.

        It calls :meth:`__next__` by default.
	**/
	public function next() : Dynamic;
	public var previous_epoch_detail : Dynamic;
	public function reset() : Dynamic;
	/**
		Serializes the internal state of the iterator.

        This is a method to support serializer protocol of Chainer.

        .. note::
           It should only serialize the internal state that changes over the
           iteration. It should not serializes what is set manually by
           users such as the batch size.
	**/
	public function serialize(serializer:Dynamic) : Dynamic;
}