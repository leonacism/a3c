package chainer.datasets;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.datasets') extern class Datasets_Module {
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
	/**
		Creates a set of training/test splits for cross validation.

		This function generates ``n_fold`` splits of the given dataset. The first
		part of each split corresponds to the training dataset, while the second
		part to the test dataset. No pairs of test datasets share any examples, and
		all test datasets together cover the whole base dataset. Each test dataset
		contains almost same number of examples (the numbers may differ up to 1).

		Args:
			dataset: Dataset to split.
			n_fold (int): Number of splits for cross validation.
			order (sequence of ints): Order of indexes with which each split is
				determined. If it is ``None``, then no permutation is used.

		Returns:
			list of tuples: List of dataset splits.
	**/
	static public function get_cross_validation_datasets(dataset:Dynamic, n_fold:Dynamic, ?order:Dynamic) : Dynamic;
	/**
		Creates a set of training/test splits for cross validation randomly.

		This function acts almost same as :func:`get_cross_validation_dataset`,
		except automatically generating random permutation.

		Args:
			dataset: Dataset to split.
			n_fold (int): Number of splits for cross validation.
			seed (int): Seed the generator used for the permutation of indexes.
				If an integer beging convertible to 32 bit unsigned integers is
				specified, it is guaranteed that each sample
				in the given dataset always belongs to a specific subset.
				If ``None``, the permutation is changed randomly.

		Returns:
			list of tuples: List of dataset splits.
	**/
	static public function get_cross_validation_datasets_random(dataset:Dynamic, n_fold:Dynamic, ?seed:Dynamic) : Dynamic;
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
	/**
		Gets the Penn Tree Bank dataset as long word sequences.

		`Penn Tree Bank <https://www.cis.upenn.edu/~treebank/>`_ is originally a
		corpus of English sentences with linguistic structure annotations. This
		function uses a variant distributed at
		`https://github.com/wojzaremba/lstm <https://github.com/wojzaremba/lstm>`_,
		which omits the annotation and splits the dataset into three parts:
		training, validation, and test.

		This function returns the training, validation, and test sets, each of
		which is represented as a long array of word IDs. All sentences in the
		dataset are concatenated by End-of-Sentence mark '<eos>', which is treated
		as one of the vocabulary.

		Returns:
			tuple of numpy.ndarray: Int32 vectors of word IDs.

		.. Seealso::
		   Use :func:`get_ptb_words_vocabulary` to get the mapping between the
		   words and word IDs.
	**/
	static public function get_ptb_words() : Dynamic;
	/**
		Gets the Penn Tree Bank word vocabulary.

		Returns:
			dict: Dictionary that maps words to corresponding word IDs. The IDs are
			used in the Penn Tree Bank long sequence datasets.

		.. seealso::
		   See :func:`get_ptb_words` for the actual datasets.
	**/
	static public function get_ptb_words_vocabulary() : Dynamic;
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
	/**
		Splits a dataset into two subsets.

		This function creates two instances of :class:`SubDataset`. These instances
		do not share any examples, and they together cover all examples of the
		original dataset.

		Args:
			dataset: Dataset to split.
			split_at (int): Position at which the base dataset is split.
			order (sequence of ints): Permutation of indexes in the base dataset.
				See the document of :class:`SubDataset` for details.

		Returns:
			tuple: Two :class:`SubDataset` objects. The first subset represents the
			examples of indexes ``order[:split_at]`` while the second subset
			represents the examples of indexes ``order[split_at:]``.
	**/
	static public function split_dataset(dataset:Dynamic, split_at:Dynamic, ?order:Dynamic) : Dynamic;
	/**
		Splits a dataset into ``n`` subsets.

		Args:
			dataset: Dataset to split.
			n(int): The number of subsets.
			order (sequence of ints): Permutation of indexes in the base dataset.
				See the document of :class:`SubDataset` for details.

		Returns:
			list: List of ``n`` :class:`SubDataset` objects.
			Each subset contains the examples of indexes
			``order[i * (len(dataset) // n):(i + 1) * (len(dataset) // n)]``
			.
	**/
	static public function split_dataset_n(dataset:Dynamic, n:Dynamic, ?order:Dynamic) : Dynamic;
	/**
		Splits a dataset into ``n`` subsets randomly.

		Args:
			dataset: Dataset to split.
			n(int): The number of subsets.
			seed (int): Seed the generator used for the permutation of indexes.
				If an integer being convertible to 32 bit unsigned integers is
				specified, it is guaranteed that each sample
				in the given dataset always belongs to a specific subset.
				If ``None``, the permutation is changed randomly.

		Returns:
			list: List of ``n`` :class:`SubDataset` objects.
				Each subset contains ``len(dataset) // n`` examples randomly chosen
				from the dataset without replacement.
	**/
	static public function split_dataset_n_random(dataset:Dynamic, n:Dynamic, ?seed:Dynamic) : Dynamic;
	/**
		Splits a dataset into two subsets randomly.

		This function creates two instances of :class:`SubDataset`. These instances
		do not share any examples, and they together cover all examples of the
		original dataset. The split is automatically done randomly.

		Args:
			dataset: Dataset to split.
			first_size (int): Size of the first subset.
			seed (int): Seed the generator used for the permutation of indexes.
				If an integer being convertible to 32 bit unsigned integers is
				specified, it is guaranteed that each sample
				in the given dataset always belongs to a specific subset.
				If ``None``, the permutation is changed randomly.

		Returns:
			tuple: Two :class:`SubDataset` objects. The first subset contains
			``first_size`` examples randomly chosen from the dataset without
			replacement, and the second subset contains the rest of the
			dataset.
	**/
	static public function split_dataset_random(dataset:Dynamic, first_size:Dynamic, ?seed:Dynamic) : Dynamic;
}