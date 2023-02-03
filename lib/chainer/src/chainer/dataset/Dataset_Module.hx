package chainer.dataset;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.dataset') extern class Dataset_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Caches a file if it does not exist, or loads it otherwise.
		This is a utility function used in dataset loading routines. The
		``creator`` creates the file to given path, and returns the content. If the
		file already exists, the ``loader`` is called instead, and it loads the
		file and returns the content.
		Note that the path passed to the creator is temporary one, and not same as
		the path given to this function. This function safely renames the file
		created by the creator to a given path, even if this function is called
		simultaneously by multiple threads or processes.
		Args:
			path (str): Path to save the cached file.
			creator: Function to create the file and returns the content. It takes
				a path to temporary place as the argument. Before calling the
				creator, there is no file at the temporary path.
			loader: Function to load the cached file and returns the content.
		Returns:
			It returns the returned values by the creator or the loader.
	**/
	static public function cache_or_load_file(path:Dynamic, creator:Dynamic, loader:Dynamic) : Dynamic;
	/**
		Downloads a file and caches it.
		It downloads a file from the URL if there is no corresponding cache. After
		the download, this function stores a cache to the directory under the
		dataset root (see :func:`set_dataset_root`). If there is already a cache
		for the given URL, it just returns the path to the cache without
		downloading the same file.
		.. note::
			This function raises :class:`OSError` when it fails to create
			the cache directory. In older version, it raised :class:`RuntimeError`.
		Args:
			url (str): URL to download from.
		Returns:
			str: Path to the downloaded file.
	**/
	static public function cached_download(url:Dynamic) : Dynamic;
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
		Gets the path to the directory of given dataset.
		The generated path is just a concatenation of the global root directory
		(see :func:`set_dataset_root` for how to change it) and the dataset name.
		The dataset name can contain slashes, which are treated as path separators.
		Args:
			dataset_name (str): Name of the dataset.
			create_directory (bool): If True (default), this function also creates
				the directory at the first time. If the directory already exists,
				then this option is ignored.
		Returns:
			str: Path to the dataset directory.
	**/
	static public function get_dataset_directory(dataset_name:Dynamic, ?create_directory:Dynamic) : Dynamic;
	/**
		Gets the path to the root directory to download and cache datasets.
		Returns:
			str: The path to the dataset root directory.
	**/
	static public function get_dataset_root() : Dynamic;
	/**
		Sets the root directory to download and cache datasets.
		There are two ways to set the dataset root directory. One is by setting the
		environment variable ``CHAINER_DATASET_ROOT``. The other is by using this
		function. If both are specified, one specified via this function is used.
		The default dataset root is ``$HOME/.chainer/dataset``.
		Args:
			path (str): Path to the new dataset root directory.
	**/
	static public function set_dataset_root(path:Dynamic) : Dynamic;
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