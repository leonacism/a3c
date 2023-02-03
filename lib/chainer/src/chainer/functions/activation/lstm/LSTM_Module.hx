package chainer.functions.activation.lstm;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.lstm') extern class LSTM_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _extract_gates(x:Dynamic) : Dynamic;
	static public function _grad_grad_sigmoid(x:Dynamic) : Dynamic;
	static public function _grad_grad_tanh(x:Dynamic, gx:Dynamic) : Dynamic;
	static public function _grad_sigmoid(x:Dynamic) : Dynamic;
	static public function _grad_tanh(x:Dynamic) : Dynamic;
	static public var _preamble : Dynamic;
	static public function _sigmoid(x:Dynamic, ?xp:Dynamic) : Dynamic;
	/**
		Long Short-Term Memory units as an activation function.
		This function implements LSTM units with forget gates. Let the previous
		cell state ``c_prev`` and the input array ``x``.
		First, the input array ``x`` is split into four arrays
		:math:`a, i, f, o` of the same shapes along the second axis. It means that
		``x`` 's second axis must have 4 times the ``c_prev`` 's second axis.
		The split input arrays are corresponding to:
			- :math:`a` : sources of cell input
			- :math:`i` : sources of input gate
			- :math:`f` : sources of forget gate
			- :math:`o` : sources of output gate
		Second, it computes the updated cell state ``c`` and the outgoing signal
		``h`` as:
		.. math::
			c &= \\tanh(a) \\sigma(i)
			   + c_{\\text{prev}} \\sigma(f), \\\\
			h &= \\tanh(c) \\sigma(o),
		where :math:`\\sigma` is the elementwise sigmoid function.
		These are returned as a tuple of two variables.
		This function supports variable length inputs. The mini-batch size of
		the current input must be equal to or smaller than that of the previous
		one. When mini-batch size of ``x`` is smaller than that of ``c``, this
		function only updates ``c[0:len(x)]`` and doesn't change the rest of ``c``,
		``c[len(x):]``.
		So, please sort input sequences in descending order of lengths before
		applying the function.
		Args:
			c_prev (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable that holds the previous cell state. The cell state
				should be a zero array or the output of the previous call of LSTM.
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable that holds the sources of cell input, input gate, forget
				gate and output gate. It must have the second dimension whose size
				is four times of that of the cell state.
		Returns:
			tuple: Two :class:`~chainer.Variable` objects ``c`` and ``h``.
			``c`` is the updated cell state. ``h`` indicates the outgoing signal.
		See the original paper proposing LSTM with forget gates:
		`Long Short-Term Memory in Recurrent Neural Networks \
		<http://www.felixgers.de/papers/phd.pdf>`_.
		.. seealso::
			:class:`~chainer.links.LSTM`
		.. admonition:: Example
			Assuming ``y`` is the current incoming signal, ``c`` is the previous
			cell state, and ``h`` is the previous outgoing signal from an ``lstm``
			function. Each of ``y``, ``c`` and ``h`` has ``n_units`` channels.
			Most typical preparation of ``x`` is:
			>>> n_units = 100
			>>> y = chainer.Variable(np.zeros((1, n_units), 'f'))
			>>> h = chainer.Variable(np.zeros((1, n_units), 'f'))
			>>> c = chainer.Variable(np.zeros((1, n_units), 'f'))
			>>> model = chainer.Chain()
			>>> with model.init_scope():
			...   model.w = L.Linear(n_units, 4 * n_units)
			...   model.v = L.Linear(n_units, 4 * n_units)
			>>> x = model.w(y) + model.v(h)
			>>> c, h = F.lstm(c, x)
			It corresponds to calculate the input array ``x``, or the input
			sources :math:`a, i, f, o`, from the current incoming signal ``y`` and
			the previous outgoing signal ``h``. Different parameters are used for
			different kind of input sources.
		.. note::
			We use the naming rule below.
			- incoming signal
				The formal input of the formulation of LSTM (e.g. in NLP, word
				vector or output of lower RNN layer). The input of
				:class:`chainer.links.LSTM` is the *incoming signal*.
			- input array
				The array which is linear transformed from *incoming signal* and
				the previous outgoing signal. The *input array* contains four
				sources, the sources of cell input, input gate, forget gate and
				output gate. The input of :class:`chainer.functions.LSTM` is the
				*input array*.
	**/
	static public function lstm(c_prev:Dynamic, x:Dynamic) : Dynamic;
}