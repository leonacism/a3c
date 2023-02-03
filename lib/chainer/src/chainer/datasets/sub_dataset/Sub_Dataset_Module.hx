package chainer.datasets.sub_dataset;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.datasets.sub_dataset') extern class Sub_Dataset_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;

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