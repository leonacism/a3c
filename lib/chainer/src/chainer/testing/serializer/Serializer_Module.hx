package chainer.testing.serializer;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.testing.serializer') extern class Serializer_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Saves ``src`` and loads it to ``dst`` using a de/serializer.
		This function simply runs a serialization and deserialization to check if
		the serialization code is correctly implemented. The save and load are
		done within a temporary directory.
		Args:
			src: An object to save from.
			dst: An object to load into.
			filename (str): File name used during the save/load.
			saver (callable): Function that saves the source object.
			loader (callable): Function that loads the file into the destination
				object.
	**/
	static public function save_and_load(src:Dynamic, dst:Dynamic, filename:Dynamic, saver:Dynamic, loader:Dynamic) : Dynamic;
	/**
		Saves ``src`` to an HDF5 file and loads it to ``dst``.
		This is a short cut of :func:`save_and_load` using HDF5 de/serializers.
		Args:
			src: An object to save.
			dst: An object to load to.
	**/
	static public function save_and_load_hdf5(src:Dynamic, dst:Dynamic) : Dynamic;
	/**
		Saves ``src`` to an NPZ file and loads it to ``dst``.
		This is a short cut of :func:`save_and_load` using NPZ de/serializers.
		Args:
			src: An object to save.
			dst: An object to load to.
	**/
	static public function save_and_load_npz(src:Dynamic, dst:Dynamic) : Dynamic;
}