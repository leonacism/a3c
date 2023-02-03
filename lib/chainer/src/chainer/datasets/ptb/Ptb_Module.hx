package chainer.datasets.ptb;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.datasets.ptb') extern class Ptb_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _load_words(url:Dynamic) : Dynamic;
	static public function _retrieve_ptb_words(name:Dynamic, url:Dynamic) : Dynamic;
	static public function _retrieve_word_vocabulary() : Dynamic;
	static public var _test_url : Dynamic;
	static public var _train_url : Dynamic;
	static public var _valid_url : Dynamic;
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
}