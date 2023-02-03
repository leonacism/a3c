package chainer.datasets.mnist;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.datasets.mnist') extern class Mnist_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _make_npz(path:Dynamic, urls:Dynamic) : Dynamic;
	static public function _preprocess_mnist(raw:Dynamic, withlabel:Dynamic, ndim:Dynamic, scale:Dynamic, image_dtype:Dynamic, label_dtype:Dynamic, rgb_format:Dynamic) : Dynamic;
	static public function _retrieve_mnist(name:Dynamic, urls:Dynamic) : Dynamic;
	static public function _retrieve_mnist_test() : Dynamic;
	static public function _retrieve_mnist_training() : Dynamic;
	/**
		Gets the MNIST dataset.

		`MNIST <http://yann.lecun.com/exdb/mnist/>`_ is a set of hand-written
		digits represented by grey-scale 28x28 images. In the original images, each
		pixel is represented by one-byte unsigned integer. This function
		scales the pixels to floating point values in the interval ``[0, scale]``.

		This function returns the training set and the test set of the official
		MNIST dataset. If ``withlabel`` is ``True``, each dataset consists of
		tuples of images and labels, otherwise it only consists of images.

		Args:
			withlabel (bool): If ``True``, it returns datasets with labels. In this
				case, each example is a tuple of an image and a label. Otherwise,
				the datasets only contain images.
			ndim (int): Number of dimensions of each image. The shape of each image
				is determined depending on ``ndim`` as follows:

				- ``ndim == 1``: the shape is ``(784,)``
				- ``ndim == 2``: the shape is ``(28, 28)``
				- ``ndim == 3``: the shape is ``(1, 28, 28)``

			scale (float): Pixel value scale. If it is 1 (default), pixels are
				scaled to the interval ``[0, 1]``.
			dtype: Data type of resulting image arrays.
			label_dtype: Data type of the labels.
			rgb_format (bool): if ``ndim == 3`` and ``rgb_format`` is ``True``, the
				image will be converted to rgb format by duplicating the channels
				so the image shape is (3, 28, 28). Default is ``False``.

		Returns:
			A tuple of two datasets. If ``withlabel`` is ``True``, both datasets
			are :class:`~chainer.datasets.TupleDataset` instances. Otherwise, both
			datasets are arrays of images.
	**/
	static public function get_mnist(?withlabel:Dynamic, ?ndim:Dynamic, ?scale:Dynamic, ?dtype:Dynamic, ?label_dtype:Dynamic, ?rgb_format:Dynamic) : Dynamic;
}