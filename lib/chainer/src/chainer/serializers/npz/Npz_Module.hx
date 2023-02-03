package chainer.serializers.npz;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.serializers.npz') extern class Npz_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _available : Dynamic;
	static public function _check_available() : Dynamic;
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
}