package chainer.dataset.convert;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.dataset.convert') extern class Convert_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _concat_arrays(arrays:Dynamic, padding:Dynamic) : Dynamic;
	static public function _concat_arrays_with_padding(arrays:Dynamic, padding:Dynamic) : Dynamic;
	/**
		Concatenates a list of examples into array(s).

		Dataset iterator yields a list of examples. If each example is an array,
		this function concatenates them along the newly-inserted first axis (called
		`batch dimension`) into one array. The basic behavior is same for examples
		consisting of multiple arrays, i.e., corresponding arrays of all examples
		are concatenated.

		For instance, consider each example consists of two arrays ``(x, y)``.
		Then, this function concatenates ``x`` 's into one array, and ``y`` 's
		into another array, and returns a tuple of these two arrays. Another
		example: consider each example is a dictionary of two entries whose keys
		are ``'x'`` and ``'y'``, respectively, and values are arrays. Then, this
		function concatenates ``x`` 's into one array, and ``y`` 's into another
		array, and returns a dictionary with two entries ``x`` and ``y`` whose
		values are the concatenated arrays.

		When the arrays to concatenate have different shapes, the behavior depends
		on the ``padding`` value. If ``padding`` is ``None`` (default), it raises
		an error. Otherwise, it builds an array of the minimum shape that the
		contents of all arrays can be substituted to. The padding value is then
		used to the extra elements of the resulting arrays.

		TODO(beam2d): Add an example.

		Args:
			batch (list): A list of examples. This is typically given by a dataset
				iterator.
			device (int): Device ID to which each array is sent. Negative value
				indicates the host memory (CPU). If it is omitted, all arrays are
				left in the original device.
			padding: Scalar value for extra elements. If this is None (default),
				an error is raised on shape mismatch. Otherwise, an array of
				minimum dimensionalities that can accommodate all arrays is
				created, and elements outside of the examples are padded by this
				value.

		Returns:
			Array, a tuple of arrays, or a dictionary of arrays. The type depends
			on the type of each example in the batch.
	**/
	static public function concat_examples(batch:Dynamic, ?device:Dynamic, ?padding:Dynamic) : Dynamic;
	/**
		Send an array to a given device.

		This method sends a given array to a given device. This method is used in
		:func:`~chainer.dataset.concat_examples`.
		You can also use this method in a custom converter method used in
		:class:`~chainer.training.Updater` and :class:`~chainer.training.Extension`
		such as :class:`~chainer.training.StandardUpdater` and
		:class:`~chainer.training.extensions.Evaluator`.

		See also :func:`chainer.dataset.concat_examples`.

		Args:
			device (int or None): Device ID to which an array is sent. If it is
				negative value, an array is sent to CPU. If it is positive, an
				array is sent to GPU with the given ID. If it is ``None``, an
				array is left in the original device.
			x (numpy.ndarray or cupy.ndarray): An array to send.

		Returns:
			Converted array.
	**/
	static public function to_device(device:Dynamic, x:Dynamic) : Dynamic;
}