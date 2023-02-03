package chainer.iterators.serial_iterator;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.iterators.serial_iterator', 'SerialIterator') extern class SerialIterator {
	/**
		Dataset iterator that serially reads the examples.
		This is a simple implementation of :class:`~chainer.dataset.Iterator`
		that just visits each example in either the order of indexes or a shuffled
		order.
		To avoid unintentional performance degradation, the ``shuffle`` option is
		set to ``True`` by default. For validation, it is better to set it to
		``False`` when the underlying dataset supports fast slicing. If the
		order of examples has an important meaning and the updater depends on the
		original order, this option should be set to ``False``.
		This iterator saves ``-1`` instead of ``None`` in snapshots since some
		serializers do not support ``None``.
		Args:
			dataset: Dataset to iterate.
			batch_size (int): Number of examples within each batch.
			repeat (bool): If ``True``, it infinitely loops over the dataset.
				Otherwise, it stops iteration at the end of the first epoch.
			shuffle (bool): If ``True``, the order of examples is shuffled at the
				beginning of each epoch. Otherwise, examples are extracted in the
				order of indexes.
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
	public function ___init__(dataset:Dynamic, batch_size:Dynamic, ?repeat:Dynamic, ?shuffle:Dynamic) : Dynamic;
	/**
		Returns self.
	**/
	public function __iter__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(dataset:Dynamic, batch_size:Dynamic, ?repeat:Dynamic, ?shuffle:Dynamic) : Void;
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