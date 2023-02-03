package chainer.dataset.iterator;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.dataset.iterator', 'Iterator') extern class Iterator {
	/**
		Base class of all dataset iterators.

		Iterator iterates over the dataset, yielding a minibatch at each
		iteration. Minibatch is a list of examples. Each implementation should
		implement an iterator protocol (e.g., the :meth:`__next__` method).

		Note that, even if the iterator supports setting the batch size, it does
		not guarantee that each batch always contains the same number of examples.
		For example, if you let the iterator to stop at the end of the sweep, the
		last batch may contain a fewer number of examples.

		The interface between the iterator and the underlying dataset is not fixed,
		and up to the implementation.

		Each implementation should provide the following attributes (not needed to
		be writable).

		- ``batch_size``: Number of examples within each minibatch.
		- ``epoch``: Number of completed sweeps over the dataset.
		- ``epoch_detail``: Floating point number version of the epoch. For
		  example, if the iterator is at the middle of the dataset at the third
		  epoch, then this value is 2.5.
		- ``previous_epoch_detail``: The value of ``epoch_detail`` at the previous
		  iteration. This value is ``None`` before the first iteration.
		- ``is_new_epoch``: ``True`` if the epoch count was incremented at the last
		  update.

		Each implementation should also support serialization to resume/suspend the
		iteration.
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
	public function ___init__():Dynamic;
	/**
		Returns self.
	**/
	public function __iter__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new():Void;
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