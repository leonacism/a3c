package chainer.datasets.cifar;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.datasets.cifar') extern class Cifar_Module {

	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _get_cifar(name:Dynamic, withlabel:Dynamic, ndim:Dynamic, scale:Dynamic) : Dynamic;
	static public function _pickle_load(f:Dynamic) : Dynamic;
	static public function _preprocess_cifar(images:Dynamic, labels:Dynamic, withlabel:Dynamic, ndim:Dynamic, scale:Dynamic) : Dynamic;
	/**
		Gets the CIFAR-10 dataset.

		`CIFAR-10 <https://www.cs.toronto.edu/~kriz/cifar.html>`_ is a set of small
		natural images. Each example is an RGB color image of size 32x32,
		classified into 10 groups. In the original images, each component of pixels
		is represented by one-byte unsigned integer. This function scales the
		components to floating point values in the interval ``[0, scale]``.

		This function returns the training set and the test set of the official
		CIFAR-10 dataset. If ``withlabel`` is ``True``, each dataset consists of
		tuples of images and labels, otherwise it only consists of images.

		Args:
			withlabel (bool): If ``True``, it returns datasets with labels. In this
				case, each example is a tuple of an image and a label. Otherwise,
				the datasets only contain images.
			ndim (int): Number of dimensions of each image. The shape of each image
				is determined depending on ndim as follows:

				- ``ndim == 1``: the shape is ``(3072,)``
				- ``ndim == 3``: the shape is ``(3, 32, 32)``

			scale (float): Pixel value scale. If it is 1 (default), pixels are
				scaled to the interval ``[0, 1]``.

		Returns:
			A tuple of two datasets. If ``withlabel`` is ``True``, both datasets
			are :class:`~chainer.datasets.TupleDataset` instances. Otherwise, both
			datasets are arrays of images.
	**/
	static public function get_cifar10(?withlabel:Dynamic, ?ndim:Dynamic, ?scale:Dynamic) : Dynamic;
	/**
		Gets the CIFAR-100 dataset.

		`CIFAR-100 <https://www.cs.toronto.edu/~kriz/cifar.html>`_ is a set of
		small natural images. Each example is an RGB color image of size 32x32,
		classified into 100 groups. In the original images, each component
		pixels is represented by one-byte unsigned integer. This function scales
		the components to floating point values in the interval ``[0, scale]``.

		This function returns the training set and the test set of the official
		CIFAR-100 dataset. If ``withlabel`` is ``True``, each dataset consists of
		tuples of images and labels, otherwise it only consists of images.

		Args:
			withlabel (bool): If ``True``, it returns datasets with labels. In this
				case, each example is a tuple of an image and a label. Otherwise,
				the datasets only contain images.
			ndim (int): Number of dimensions of each image. The shape of each image
				is determined depending on ndim as follows:

				- ``ndim == 1``: the shape is ``(3072,)``
				- ``ndim == 3``: the shape is ``(3, 32, 32)``

			scale (float): Pixel value scale. If it is 1 (default), pixels are
				scaled to the interval ``[0, 1]``.

		Returns:
			A tuple of two datasets. If ``withlabel`` is ``True``, both
			are :class:`~chainer.datasets.TupleDataset` instances. Otherwise, both
			datasets are arrays of images.
	**/
	static public function get_cifar100(?withlabel:Dynamic, ?ndim:Dynamic, ?scale:Dynamic) : Dynamic;
}
