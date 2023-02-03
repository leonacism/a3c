package chainer.datasets.svhn;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.datasets.svhn') extern class Svhn_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _error : Dynamic;
	static public function _make_npz(path:Dynamic, url:Dynamic) : Dynamic;
	static public function _preprocess_svhn(raw:Dynamic, withlabel:Dynamic, scale:Dynamic, image_dtype:Dynamic, label_dtype:Dynamic) : Dynamic;
	static public function _retrieve_svhn(name:Dynamic, url:Dynamic) : Dynamic;
	static public function _retrieve_svhn_test() : Dynamic;
	static public function _retrieve_svhn_training() : Dynamic;
	static public var _scipy_available : Dynamic;
	/**
		Gets the SVHN dataset.

		`The Street View House Numbers (SVHN) dataset <http://ufldl.stanford.edu/housenumbers/>`_
		is a dataset similar to MNIST but composed of cropped images of house
		numbers.
		The functionality of this function is identical to the counterpart for the
		MNIST dataset (:func:`~chainer.datasets.get_mnist`),
		with the exception that there is no ``ndim`` argument.

		.. note::
		   `SciPy <https://www.scipy.org/>`_ is required to use this feature.

		Args:
			withlabel (bool): If ``True``, it returns datasets with labels. In this
				case, each example is a tuple of an image and a label. Otherwise,
				the datasets only contain images.
			scale (float): Pixel value scale. If it is 1 (default), pixels are
				scaled to the interval ``[0, 1]``.
			dtype: Data type of resulting image arrays.
			label_dtype: Data type of the labels.

		Returns:
			A tuple of two datasets. If ``withlabel`` is ``True``, both datasets
			are :class:`~chainer.datasets.TupleDataset` instances. Otherwise, both
			datasets are arrays of images.
	**/
	static public function get_svhn(?withlabel:Dynamic, ?scale:Dynamic, ?dtype:Dynamic, ?label_dtype:Dynamic) : Dynamic;
}
