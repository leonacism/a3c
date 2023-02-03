package chainer.functions.activation.slstm;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.slstm') extern class SLSTM_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _extract_gates(x:Dynamic) : Dynamic;
	static public function _grad_sigmoid(x:Dynamic) : Dynamic;
	static public function _grad_tanh(x:Dynamic) : Dynamic;
	static public var _preamble : Dynamic;
	static public function _sigmoid(x:Dynamic) : Dynamic;
	/**
		S-LSTM units as an activation function.
		This function implements S-LSTM unit. It is an extension of LSTM unit
		applied to tree structures.
		The function is applied to binary trees. Each node has two child nodes.
		It gets four arguments, previous cell states ``c_prev1`` and ``c_prev2``,
		and input arrays ``x1`` and ``x2``.
		First both input arrays ``x1`` and ``x2`` are split into eight arrays
		:math:`a_1, i_1, f_1, o_1`, and :math:`a_2, i_2, f_2, o_2`. They have the
		same shape along the second axis.
		It means that ``x1`` and ``x2`` 's second axis must have 4 times
		the length of ``c_prev1`` and ``c_prev2``.
		The split input arrays are corresponding to:
			- :math:`a_i` : sources of cell input
			- :math:`i_i` : sources of input gate
			- :math:`f_i` : sources of forget gate
			- :math:`o_i` : sources of output gate
		It computes the updated cell state ``c`` and the outgoing signal
		``h`` as:
		.. math::
			c &= \\tanh(a_1 + a_2) \\sigma(i_1 + i_2)
			   + c_{\\text{prev}1} \\sigma(f_1)
			   + c_{\\text{prev}2} \\sigma(f_2), \\\\
			h &= \\tanh(c) \\sigma(o_1 + o_2),
		where :math:`\\sigma` is the elementwise sigmoid function.
		The function returns ``c`` and ``h`` as a tuple.
		Args:
			c_prev1 (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable that holds the previous cell state of the first child
				node. The cell state should be a zero array or the output of
				the previous call of LSTM.
			c_prev2 (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable that holds the previous cell state of the second child
				node.
			x1 (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable that holds the sources of cell input, input gate, forget
				gate and output gate from the first child node. It must have the
				second dimension whose size is four times of that of the cell
				state.
			x2 (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable that holds the input sources from the second child node.
		Returns:
			tuple: Two :class:`~chainer.Variable` objects ``c`` and ``h``. ``c`` is
			the cell state. ``h`` indicates the outgoing signal.
		See detail in paper: `Long Short-Term Memory Over Tree Structures \
		<https://arxiv.org/abs/1503.04881>`_.
		.. admonition:: Example
			Assuming ``c1``, ``c2`` is the previous cell state of children,
			and ``h1``, ``h2`` is the previous outgoing signal from children.
			Each of ``c1``, ``c2``, ``h1`` and ``h2`` has ``n_units`` channels.
			Most typical preparation of ``x1``, ``x2`` is:
			>>> n_units = 100
			>>> h1 = chainer.Variable(np.zeros((1, n_units), 'f'))
			>>> h2 = chainer.Variable(np.zeros((1, n_units), 'f'))
			>>> c1 = chainer.Variable(np.zeros((1, n_units), 'f'))
			>>> c2 = chainer.Variable(np.zeros((1, n_units), 'f'))
			>>> model1 = chainer.Chain()
			>>> with model1.init_scope():
			...   model1.w = L.Linear(n_units, 4 * n_units)
			...   model1.v = L.Linear(n_units, 4 * n_units)
			>>> model2 = chainer.Chain()
			>>> with model2.init_scope():
			...   model2.w = L.Linear(n_units, 4 * n_units)
			...   model2.v = L.Linear(n_units, 4 * n_units)
			>>> x1 = model1.w(c1) + model1.v(h1)
			>>> x2 = model2.w(c2) + model2.v(h2)
			>>> c, h = F.slstm(c1, c2, x1, x2)
			It corresponds to calculate the input array ``x1``, or the input
			sources :math:`a_1, i_1, f_1, o_1` from the previous cell state of
			first child node ``c1``, and the previous outgoing signal from first
			child node ``h1``. Different parameters are used for different kind of
			input sources.
	**/
	static public function slstm(c_prev1:Dynamic, c_prev2:Dynamic, x1:Dynamic, x2:Dynamic) : Dynamic;
}