package chainer.serializers;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.serializers') extern class Serializers_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __path__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Loads an object from the file in HDF5 format.
		This is a short-cut function to load from an HDF5 file that contains only
		one object. If you want to load multiple objects from one HDF5 file, use
		:class:`HDF5Deserializer` directly by passing appropriate
		:class:`h5py.Group` objects.
		Args:
			filename (str): Name of the file to be loaded.
			obj: Object to be deserialized. It must support serialization protocol.
		.. note::
			Currently :func:`load_hdf5` only supports loading an actual file on
			file system due to a limitation of HD5F library.
			See `h5py/h5py#687 <https://github.com/h5py/h5py/issues/687>`_ for
			details.
		.. seealso::
			:func:`chainer.serializers.save_hdf5`
	**/
	static public function load_hdf5(filename:Dynamic, obj:Dynamic) : Dynamic;
	/**
		Loads an object from the file in NPZ format.
		This is a short-cut function to load from an `.npz` file that contains only
		one object.
		Args:
			file (str or file-like): File to be loaded.
			obj: Object to be deserialized. It must support serialization protocol.
			path (str): The path in the hierarchy of the serialized data under
				which the data is to be loaded. The default behavior (blank) will
				load all data under the root path.
			strict (bool): If ``True``, the deserializer raises an error when an
				expected value is not found in the given NPZ file. Otherwise,
				it ignores the value and skip deserialization.
		.. seealso::
			:func:`chainer.serializers.save_npz`
	**/
	static public function load_npz(file:Dynamic, obj:Dynamic, ?path:Dynamic, ?strict:Dynamic) : Dynamic;
	/**
		Saves an object to the file in HDF5 format.
		This is a short-cut function to save only one object into an HDF5 file. If
		you want to save multiple objects to one HDF5 file, use
		:class:`HDF5Serializer` directly by passing appropriate :class:`h5py.Group`
		objects.
		Args:
			filename (str): Target file name.
			obj: Object to be serialized. It must support serialization protocol.
			compression (int): Gzip compression level.
		.. note::
			Currently :func:`save_hdf5` only supports writing to an actual file on
			file system due to a limitation of HD5F library.
			See `h5py/h5py#687 <https://github.com/h5py/h5py/issues/687>`_ for
			details.
		.. seealso::
			:func:`chainer.serializers.load_hdf5`
	**/
	static public function save_hdf5(filename:Dynamic, obj:Dynamic, ?compression:Dynamic) : Dynamic;
	/**
		Saves an object to the file in NPZ format.
		This is a short-cut function to save only one object into an NPZ file.
		Args:
			file (str or file-like): Target file to write to.
			obj: Object to be serialized. It must support serialization protocol.
			compression (bool): If ``True``, compression in the resulting zip file
				is enabled.
		.. seealso::
			:func:`chainer.serializers.load_npz`
	**/
	static public function save_npz(file:Dynamic, obj:Dynamic, ?compression:Dynamic) : Dynamic;
}