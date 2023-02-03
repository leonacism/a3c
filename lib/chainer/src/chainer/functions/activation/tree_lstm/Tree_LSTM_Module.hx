package chainer.functions.activation.tree_lstm;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.tree_lstm') extern class Tree_LSTM_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Extract gates by split.
		This is different from ``_extract_gates`` in lstm.py,
		which is as follows::
				r = x.reshape((x.shape[0], x.shape[1] // 4, 4) + x.shape[2:])
				return (r[:, :, i] for i in six.moves.range(4))
		In other words, it thinly slices ``x`` and merge them,
		while this thickly slices ``x``.
	**/
	static public function _extract_gates(x:Dynamic, ?n_split:Dynamic) : Dynamic;
	static public function _grad_sigmoid(x:Dynamic) : Dynamic;
	static public function _grad_tanh(x:Dynamic) : Dynamic;
	static public var _preamble : Dynamic;
	static public function _sigmoid(x:Dynamic) : Dynamic;
	/**
		TreeLSTM unit as an activation function.
		This function implements TreeLSTM units both for
		N-ary TreeLSTM and Child-Sum TreeLSTM.
		Let the children cell states
		:math:`c_{\\text{1}}, c_{\\text{2}}, \\dots, c_{\\text{N}}`,
		and the incoming signal :math:`x`.
		First, the incoming signal :math:`x` is split into (3 + N) arrays
		:math:`a, i, o, f_{\\text{1}}, f_{\\text{2}}, ..., f_{\\text{N}}`
		of the same shapes along the second axis.
		It means that :math:`x` 's second axis must have (3 + N) times
		of the length of each :math:`c_{n}`.
		The splitted input signals are corresponding to:
			- :math:`a` : sources of cell input
			- :math:`i` : sources of input gate
			- :math:`o` : sources of output gate
			- :math:`f_{n}` : sources of forget gate for n-th ary
		Second, it computes outputs as:
		.. math::
			c &= \\tanh(a) \\text{sigmoid}(i) \\\\
			  & + c_{\\text{1}} \\text{sigmoid}(f_{\\text{1}}), \\\\
			  & + c_{\\text{2}} \\text{sigmoid}(f_{\\text{2}}), \\\\
			  & + ..., \\\\
			  & + c_{\\text{N}} \\text{sigmoid}(f_{\\text{N}}), \\\\
			h &= \\tanh(c) \\text{sigmoid}(o).
		These are returned as a tuple of (N + 1) variables.
		Args:
			inputs (list of :class:`~chainer.Variable`): Variable arguments which
				include all cell vectors from child-nodes, and an input vector.
				Each of the cell vectors and the input vector is
				:class:`~chainer.Variable`.
				The input vector must have the second dimension whose size
				is (N + 3) times of that of each cell,
				where N denotes the total number of cells.
		Returns:
			tuple: Two :class:`~chainer.Variable` objects ``c`` and ``h``. ``c`` is
			the updated cell state. ``h`` indicates the outgoing signal.
		See the papers for details: `Improved Semantic Representations From \
		Tree-Structured Long Short-Term Memory Networks \
		<http://www.aclweb.org/anthology/P15-1150>`_ and
		`A Fast Unified Model for Parsing and Sentence Understanding \
		<https://arxiv.org/pdf/1603.06021.pdf>`_.
		Tai et al.'s N-Ary TreeLSTM is little extended in
		Bowman et al., and this link is based on
		the variant by Bowman et al.
		Specifically, eq. 10 in Tai et al. only has one :math:`W` matrix
		to be applied to :math:`x`, consistently for all children.
		On the other hand, Bowman et al.'s model has multiple matrices,
		each of which affects the forget gate for each child's cell individually.
		.. admonition:: Example
			Assuming ``y`` is the current input signal, ``c`` is the previous cell
			state, and ``h`` is the previous output signal from an
			:meth:`~chainer.functions.tree_lstm` function.
			Each of ``y``, ``c`` and ``h`` has ``n_units`` channels.
			Using 2-ary (binary) TreeLSTM,
			most typical preparation of ``x`` is:
			>>> model = chainer.Chain()
			>>> with model.init_scope():
			...   model.w = L.Linear(10, 5 * 10)
			...   model.v1 = L.Linear(10, 5 * 10)
			...   model.v2 = L.Linear(10, 5 * 10)
			>>> y = np.random.uniform(-1, 1, (4, 10)).astype('f')
			>>> h1 = np.random.uniform(-1, 1, (4, 10)).astype('f')
			>>> h2 = np.random.uniform(-1, 1, (4, 10)).astype('f')
			>>> c1 = np.random.uniform(-1, 1, (4, 10)).astype('f')
			>>> c2 = np.random.uniform(-1, 1, (4, 10)).astype('f')
			>>> x = model.w(y) + model.v1(h1) + model.v2(h2)
			>>> c, h = F.tree_lstm(c1, c2, x)
			It corresponds to calculate the input sources
			:math:`a, i, o, f_{\\text{1}}, f_{\\text{2}}`
			from the current input ``y`` and the children's outputs
			``h1`` and ``h2``. Different parameters are used for different kind of
			input sources.
	**/
	static public function tree_lstm(?inputs:python.VarArgs<Dynamic>) : Dynamic;
}