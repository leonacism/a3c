package chainer.datasets.image_dataset;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.datasets.image_dataset', 'ImageDataset') extern class ImageDataset {
	/**
		Dataset of images built from a list of paths to image files.

		This dataset reads an external image file on every call of the
		:meth:`__getitem__` operator. The paths to the image to retrieve is given
		as either a list of strings or a text file that contains paths in distinct
		lines.

		Each image is automatically converted to arrays of shape
		``channels, height, width``, where ``channels`` represents the number of
		channels in each pixel (e.g., 1 for grey-scale images, and 3 for RGB-color
		images).

		.. note::
		   **This dataset requires the Pillow package being installed.** In order
		   to use this dataset, install Pillow (e.g. by using the command ``pip
		   install Pillow``). Be careful to prepare appropriate libraries for image
		   formats you want to use (e.g. libpng for PNG images, and libjpeg for JPG
		   images).

		.. warning::
		   **You are responsible for preprocessing the images before feeding them
		   to a model.** For example, if your dataset contains both RGB and
		   grayscale images, make sure that you convert them to the same format.
		   Otherwise you will get errors because the input dimensions are different
		   for RGB and grayscale images.

		Args:
			paths (str or list of strs): If it is a string, it is a path to a text
				file that contains paths to images in distinct lines. If it is a
				list of paths, the ``i``-th element represents the path to the
				``i``-th image. In both cases, each path is a relative one from the
				root path given by another argument.
			root (str): Root directory to retrieve images from.
			dtype: Data type of resulting image arrays.
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
	public function ___init__(paths:Dynamic, ?root:Dynamic, ?dtype:Dynamic) : Dynamic;
	public function __init_subclass__() : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(paths:Dynamic, ?root:Dynamic, ?dtype:Dynamic):Void;
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