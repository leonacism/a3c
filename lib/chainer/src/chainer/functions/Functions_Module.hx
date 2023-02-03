package chainer.functions;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions') extern class Functions_Module {
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
		Clipped Rectifier Unit function.
		For a clipping value :math:`z(>0)`, it computes
		.. math:: \\text{ClippedReLU}(x, z) = \\min(\\max(0, x), z).
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_n)`-shaped float array.
			z (float): Clipping value. (default = 20.0)
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_n)`-shaped float array.
		.. admonition:: Example
			>>> x = np.random.uniform(-100, 100, (10, 20)).astype('f')
			>>> z = 10.0
			>>> np.any(x < 0)
			True
			>>> np.any(x > z)
			True
			>>> y = F.clipped_relu(x, z=z)
			>>> np.any(y.data < 0)
			False
			>>> np.any(y.data > z)
			False
	**/
	static public function clipped_relu(x:Dynamic, ?z:Dynamic) : Dynamic;
	/**
		Concatenated Rectified Linear Unit function.
		This function is expressed as follows
		 .. math:: f(x) = (\\max(0, x), \\max(0, -x)).
		Here, two output values are concatenated along an axis.
		See: https://arxiv.org/abs/1603.05201
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			axis (int): Axis that the output values are concatenated along.
				Default is 1.
		Returns:
			~chainer.Variable: Output variable of concatenated array.
			If the axis is 1, A :math:`(s_1, s_2 \\times 2, ..., s_N)`-shaped float
			array.
		.. admonition:: Example
			>>> x = np.array([[-1, 0], [2, -3]], 'f')
			>>> x
			array([[-1.,  0.],
				   [ 2., -3.]], dtype=float32)
			>>> y = F.crelu(x, axis=1)
			>>> y.data
			array([[0., 0., 1., 0.],
				   [2., 0., 0., 3.]], dtype=float32)
	**/
	static public function crelu(x:Dynamic, ?axis:Dynamic) : Dynamic;
	/**
		Exponential Linear Unit function.
		For a parameter :math:`\\alpha`, it is expressed as
		.. math::
			f(x) = \\left \\{ \\begin{array}{ll}
			x & {\\rm if}~ x \\ge 0 \\\\
			\\alpha (\\exp(x) - 1) & {\\rm if}~ x < 0,
			\\end{array} \\right.
		See: https://arxiv.org/abs/1511.07289
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			alpha (float): Parameter :math:`\\alpha`. Default is 1.0.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.array([[-1, 0], [2, -3]], 'f')
			>>> x
			array([[-1.,  0.],
				   [ 2., -3.]], dtype=float32)
			>>> y = F.elu(x, alpha=1.)
			>>> y.data
			array([[-0.63212055,  0.        ],
				   [ 2.        , -0.95021296]], dtype=float32)
	**/
	static public function elu(x:Dynamic, ?alpha:Dynamic) : Dynamic;
	/**
		Element-wise hard-sigmoid function.
		This function is defined as
		.. math::
			f(x) = \\left \\{ \\begin{array}{ll}
			0 & {\\rm if}~ x < -2.5 \\\\
			0.2 x + 0.5 & {\\rm if}~ -2.5 < x < 2.5 \\\\
			1 & {\\rm if}~ 2.5 < x.
			\\end{array} \\right.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			It maps the input values into the range of :math:`[0, 1]`.
			>>> x = np.array([-2.6, -1, 0, 1, 2.6])
			>>> x
			array([-2.6, -1. ,  0. ,  1. ,  2.6])
			>>> F.hard_sigmoid(x).data
			array([0. , 0.3, 0.5, 0.7, 1. ])
	**/
	static public function hard_sigmoid(x:Dynamic) : Dynamic;
	/**
		Leaky Rectified Linear Unit function.
		This function is expressed as
		.. math::
			f(x) = \\left \\{ \\begin{array}{ll}
			x  & {\\rm if}~ x \\ge 0 \\\\
			ax & {\\rm if}~ x < 0,
			\\end{array} \\right.
		where :math:`a` is a configurable slope value.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			slope (float): Slope value :math:`a`.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.array([[-1, 0], [2, -3], [-2, 1]], 'f')
			>>> x
			array([[-1.,  0.],
				   [ 2., -3.],
				   [-2.,  1.]], dtype=float32)
			>>> F.leaky_relu(x, slope=0.2).data
			array([[-0.2,  0. ],
				   [ 2. , -0.6],
				   [-0.4,  1. ]], dtype=float32)
	**/
	static public function leaky_relu(x:Dynamic, ?slope:Dynamic) : Dynamic;
	/**
		Channel-wise log-softmax function.
		This function computes its logarithm of softmax along the second axis.
		Let :math:`c = (c_1, c_2, \\dots, c_D)` be the slice of ``x`` along with
		the second axis. For each slice :math:`c`, it computes the logarithm of
		the function :math:`f(c)` defined as
		.. math::
			f(c) = {\\exp(c) \\over \\sum_{d} \\exp(c_d)}.
		This method is theoretically equivalent to ``log(softmax(x))`` but is more
		stable.
		.. note::
			``log(softmax(x))`` may cause underflow when ``x`` is too small,
			because ``softmax(x)`` may returns ``0``.
			``log_softmax`` method is more stable.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable.
				A :math:`n`-dimensional (:math:`n \\geq 2`) float array.
		Returns:
			~chainer.Variable: Output variable.
			A :math:`n`-dimensional (:math:`n \\geq 2`) float array, which is the
			same shape with x.
		.. seealso:: :func:`~chainer.functions.softmax`
		.. admonition:: Example
			>>> x = np.array([[0, 1, 2], [0, 2, 4]], 'f')
			>>> x
			array([[0., 1., 2.],
				   [0., 2., 4.]], dtype=float32)
			>>> F.log_softmax(x).data
			array([[-2.407606  , -1.4076059 , -0.4076059 ],
				   [-4.1429315 , -2.1429315 , -0.14293146]], dtype=float32)
			>>> np.allclose(F.log_softmax(x).data, F.log(F.softmax(x)).data)
			True
	**/
	static public function log_softmax(x:Dynamic) : Dynamic;
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
	/**
		Maxout activation function.
		It accepts an input tensor ``x``, reshapes the ``axis`` dimension
		(say the size being ``M * pool_size``) into two dimensions
		``(M, pool_size)``, and takes maximum along the ``axis`` dimension.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`n`-dimensional (:math:`n \\ge` ``axis``)
				float array. In general, its first dimension is assumed to be the
				*minibatch dimension*. The other dimensions are treated as one
				concatenated dimension.
			pool_size (int):
				The size used for downsampling of pooling layer.
			axis (int):
				The ``axis`` dimension to be reshaped. The size of ``axis``
				dimension should be ``M * pool_size``.
		Returns:
			~chainer.Variable:
				Output variable. The shape of the output is same as ``x`` except
				that ``axis`` dimension is transformed from ``M * pool_size`` to
				``M``.
		.. seealso:: :class:`~chainer.links.Maxout`
		.. admonition:: Example
			Typically, ``x`` is the output of a linear layer or a convolution
			layer. The following is the example where we use :func:`maxout` in
			combination with a Linear link.
			>>> in_size, out_size, pool_size = 10, 10, 10
			>>> bias = np.arange(out_size * pool_size).astype('f')
			>>> l = L.Linear(in_size, out_size * pool_size, initial_bias=bias)
			>>> x = np.zeros((1, in_size), 'f')  # prepare data
			>>> x = l(x)
			>>> y = F.maxout(x, pool_size)
			>>> x.shape
			(1, 100)
			>>> y.shape
			(1, 10)
			>>> x.reshape((out_size, pool_size)).data
			array([[ 0.,  1.,  2.,  3.,  4.,  5.,  6.,  7.,  8.,  9.],
				   [10., 11., 12., 13., 14., 15., 16., 17., 18., 19.],
				   [20., 21., 22., 23., 24., 25., 26., 27., 28., 29.],
				   [30., 31., 32., 33., 34., 35., 36., 37., 38., 39.],
				   [40., 41., 42., 43., 44., 45., 46., 47., 48., 49.],
				   [50., 51., 52., 53., 54., 55., 56., 57., 58., 59.],
				   [60., 61., 62., 63., 64., 65., 66., 67., 68., 69.],
				   [70., 71., 72., 73., 74., 75., 76., 77., 78., 79.],
				   [80., 81., 82., 83., 84., 85., 86., 87., 88., 89.],
				   [90., 91., 92., 93., 94., 95., 96., 97., 98., 99.]], \
				dtype=float32)
			>>> y.data
			array([[ 9., 19., 29., 39., 49., 59., 69., 79., 89., 99.]], \
				dtype=float32)
	**/
	static public function maxout(x:Dynamic, pool_size:Dynamic, ?axis:Dynamic) : Dynamic;
	/**
		Parametric ReLU function.
		It accepts two arguments: an input ``x`` and a weight array ``W``
		and computes the output as :math:`PReLU(x) = \\max(x, W*x)`,
		where :math:`*` is an elementwise multiplication for each sample in the
		batch.
		When the PReLU function is combined with two-dimensional convolution, the
		elements of parameter :math:`W` are typically shared across the same filter
		of different pixels. In order to support such usage, this function supports
		the shape of parameter array that indicates leading dimensions of input
		arrays except the batch dimension.
		For example, if :math:`W` has the shape of :math:`(2, 3, 4)`,
		:math:`x` must have the shape of :math:`(B, 2, 3, 4, S_1, ..., S_N)`
		where :math:`B` is the batch size and the number of trailing :math:`S`'s
		:math:`N` is an arbitrary non-negative integer.
		Args:
			x (~chainer.Variable): Input variable.
				Its first argument is assumed to be the minibatch dimension.
			W (~chainer.Variable): Weight variable.
		Returns:
			~chainer.Variable: Output variable
		.. seealso:: :class:`~chainer.links.PReLU`
	**/
	static public function prelu(x:Dynamic, W:Dynamic) : Dynamic;
	/**
		Rectified Linear Unit function.
		.. math:: f(x)=\\max(0, x).
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.array([[-1, 0], [2, -3], [-2, 1]], 'f')
			>>> np.any(x < 0)
			True
			>>> y = F.relu(x)
			>>> np.any(y.data < 0)
			False
			>>> y.shape
			(3, 2)
	**/
	static public function relu(x:Dynamic) : Dynamic;
	/**
		Scaled Exponential Linear Unit function.
		For parameters :math:`\\alpha` and :math:`\\lambda`, it is expressed as
		.. math::
			f(x) = \\lambda \\left \\{ \\begin{array}{ll}
			x & {\\rm if}~ x \\ge 0 \\\\
			\\alpha (\\exp(x) - 1) & {\\rm if}~ x < 0,
			\\end{array} \\right.
		See: https://arxiv.org/abs/1706.02515
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			alpha (float): Parameter :math:`\\alpha`.
			scale (float): Parameter :math:`\\lambda`.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
	**/
	static public function selu(x:Dynamic, ?alpha:Dynamic, ?scale:Dynamic) : Dynamic;
	/**
		Element-wise sigmoid logistic function.
		 .. math:: f(x)=(1 + \\exp(-x))^{-1}.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			It maps the input values into the range of :math:`[0, 1]`.
			>>> x = np.arange(-2, 3, 2).astype('f')
			>>> x
			array([-2.,  0.,  2.], dtype=float32)
			>>> F.sigmoid(x)
			variable([0.11920291, 0.5       , 0.8807971 ])
	**/
	static public function sigmoid(x:Dynamic) : Dynamic;
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
	/**
		Softmax function.
		This function computes its softmax along an axis. Let
		:math:`c = (c_1, c_2, \\dots, c_D)` be the slice of ``x`` along with
		the axis. For each slice :math:`c`, it computes the function :math:`f(c)`
		defined as :math:`f(c)={\\exp(c) \\over \\sum_{d} \\exp(c_d)}`.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable.
				A :math:`n`-dimensional (:math:`n \\geq 2`) float array.
			axis (int): The axis along which the softmax is to be computed.
		Returns:
			~chainer.Variable: Output variable.
			A :math:`n`-dimensional (:math:`n \\geq 2`) float array, which is the
			same shape with x.
		.. admonition:: Example
			>>> x = np.array([[0, 1, 2], [0, 2, 4]], 'f')
			>>> x
			array([[0., 1., 2.],
				   [0., 2., 4.]], dtype=float32)
			>>> y = F.softmax(x, axis=1)
			>>> y.data
			array([[0.09003057, 0.24472848, 0.66524094],
				   [0.01587624, 0.11731043, 0.86681336]], dtype=float32)
			>>> F.sum(y, axis=1).data
			array([1., 1.], dtype=float32)
	**/
	static public function softmax(x:Dynamic, ?axis:Dynamic) : Dynamic;
	/**
		Element-wise softplus function.
		The softplus function is the smooth approximation of ReLU.
		.. math:: f(x)=\\frac{1}{\\beta}\\log(1 + \\exp(\\beta x)),
		where :math:`\\beta` is a parameter. The function becomes curved
		and akin to ReLU as the :math:`\\beta` is increasing.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
			beta (float): Parameter :math:`\\beta`.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.arange(-2, 3, 2).astype('f')
			>>> x
			array([-2.,  0.,  2.], dtype=float32)
			>>> F.softplus(x, beta=1.0).data
			array([0.126928 , 0.6931472, 2.126928 ], dtype=float32)
	**/
	static public function softplus(x:Dynamic, ?beta:Dynamic) : Dynamic;
	/**
		Elementwise hyperbolic tangent function.
		 .. math:: f(x)=\\tanh(x).
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable. A :math:`(s_1, s_2, ..., s_N)`-shaped float array.
		Returns:
			~chainer.Variable: Output variable. A
			:math:`(s_1, s_2, ..., s_N)`-shaped float array.
		.. admonition:: Example
			>>> x = np.arange(-1, 4, 2).astype('f')
			>>> x
			array([-1.,  1.,  3.], dtype=float32)
			>>> F.tanh(x).data
			array([-0.7615942,  0.7615942,  0.9950548], dtype=float32)
	**/
	static public function tanh(x:Dynamic) : Dynamic;
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
	
	/**
		Elementwise exponential function.
	**/
	static public function exp(x:Dynamic) : Dynamic;
	/**
		Elementwise natural logarithm function.
	**/
	static public function log(x:Dynamic) : Dynamic;
	/**
		Elementwise logarithm function to the base 2.
		.. math::
		   y_i = \\log_2 x_i.
		Args:
			x (~chainer.Variable): Input variable.
		Returns:
			~chainer.Variable: Output variable.
	**/
	static public function log2(x:Dynamic) : Dynamic;
	/**
		Elementwise logarithm function to the base 10.
		.. math::
		   y_i = \\log_{10} x_i.
		Args:
			x (~chainer.Variable): Input variable.
		Returns:
			~chainer.Variable: Output variable.
	**/
	static public function log10(x:Dynamic) : Dynamic;
	/**
		Sum of array elements over a given axis.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Elements to sum.
				A :math:`(s_1, s_2, ..., s_N)` -shaped float array.
			axis (None, int, or tuple of int): Axis along which a sum is performed.
				The default (axis = None) is perform a sum over all the dimensions
				of the input array.
			keepdims (bool): If ``True``, the specified axes are remained as axes
				of length one.
		Returns:
			~chainer.Variable: Output variable.
		.. admonition:: Example
			>>> x = np.arange(6).reshape(2,3).astype('f')
			>>> x
			array([[0., 1., 2.],
				   [3., 4., 5.]], dtype=float32)
			>>> y = F.sum(x)
			>>> y.shape
			()
			>>> y.data
			array(15., dtype=float32)
			>>> y = F.sum(x, axis=1)
			>>> y.shape
			(2,)
			>>> y.data
			array([ 3., 12.], dtype=float32)
			>>> y = F.sum(x, keepdims=True)
			>>> y.shape
			(1, 1)
			>>> y.data
			array([[15.]], dtype=float32)
	**/
	static public function sum(x:Dynamic, ?axis:Dynamic, ?keepdims:Dynamic) : Dynamic;
	/**
		Broadcast given variables.
		Args:
			args (:class:`~chainer.Variable` or :class:`numpy.ndarray` \
			or :class:`cupy.ndarray`):
				Input variables to be broadcasted. Each dimension of the shapes \
				of the input variables must have the same size.
		Returns:
			~chainer.Variable: :class:`~chainer.Variable` or tuple of \
				:class:`~chainer.Variable` objects which are broadcasted \
				from given arguments.
		.. admonition:: Example
			>>> x = np.random.uniform(0, 1, (3, 2)).astype('f')
			>>> y = F.broadcast(x)
			>>> np.all(x == y.data)
			True
			>>> z = np.random.uniform(0, 1, (3, 2)).astype('f')
			>>> y, w = F.broadcast(x, z)
			>>> np.all(x == y.data) & np.all(z == w.data)
			True
	**/
	static public function broadcast(?args:python.VarArgs<Dynamic>) : Dynamic;
	/**
		Broadcast a given variable to a given shape.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variable be broadcasted. A \
				:math:`(s_1, s_2, ..., s_N)`-shaped float array.
			shape (tuple): Tuple of :class:`int` of the shape of the \
				output variable.
		Returns:
			~chainer.Variable: Output variable broadcasted to the given shape.
		.. admonition:: Example
			>>> x = np.arange(0, 3)
			>>> x
			array([0, 1, 2])
			>>> y = F.broadcast_to(x, (3, 3))
			>>> y.data
			array([[0, 1, 2],
				   [0, 1, 2],
				   [0, 1, 2]])
	**/
	static public function broadcast_to(x:Dynamic, shape:Dynamic) : Dynamic;
	/**
		Concatenates given variables along an axis.
		Args:
			xs (tuple of :class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Input variables to be concatenated. The variables must have the \
				same shape, except in the dimension corresponding to axis.
			axis (int): The axis along which the arrays will be joined. Default \
				is 1.
		Returns:
			~chainer.Variable: The concatenated variable.
		.. admonition:: Example
			>>> x = np.arange(0, 12).reshape(3, 4)
			>>> x
			array([[ 0,  1,  2,  3],
				   [ 4,  5,  6,  7],
				   [ 8,  9, 10, 11]])
			>>> y = np.arange(0, 3).reshape(3, 1)
			>>> y
			array([[0],
				   [1],
				   [2]])
			>>> z = F.concat((x, y), axis=1)
			>>> z.data
			array([[ 0,  1,  2,  3,  0],
				   [ 4,  5,  6,  7,  1],
				   [ 8,  9, 10, 11,  2]])
	**/
	static public function concat(xs:Dynamic, ?axis:Dynamic) : Dynamic;
	/**
		Select elements stored in given indices.
		This function returns ``t.choose(x.T)``, that means
		``y[i] == x[i, t[i]]`` for all ``i``.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable storing arrays. A two-dimensional float array.
			t (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`):
				Variable storing index numbers. A one-dimensional int array.
				Length of the ``t`` should be equal to ``x.shape[0]``.
		Returns:
			~chainer.Variable: Variable that holds ``t``-th element of ``x``.
		.. admonition:: Example
			>>> x = np.array([[0, 1, 2], [3, 4, 5]], np.float32)
			>>> t = np.array([0, 2], np.int32)
			>>> y = F.select_item(x, t)
			>>> y.shape
			(2,)
			>>> y.data
			array([0., 5.], dtype=float32)
	**/
	static public function select_item(x:Dynamic, t:Dynamic) : Dynamic;

	/**
		Linear function, or affine transformation.
		It accepts two or three arguments: an input minibatch ``x``, a weight
		matrix ``W``, and optionally a bias vector ``b``. It computes
		.. math:: Y = xW^\\top + b.
		Args:
			x (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`): Input variable, which is a :math:`(s_B, s_1, \
				s_2, ..., s_n)`-shaped float array. Its first dimension
				:math:`(s_B)` is assumed to be the *minibatch dimension*. The
				other dimensions are treated as concatenated one dimension whose
				size must be :math:`(s_1 * ... * s_n = N)`.
			W (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`): Weight variable of shape :math:`(M, N)`,
				where :math:`(N = s_1 * ... * s_n)`.
			b (:class:`~chainer.Variable` or :class:`numpy.ndarray` or \
			:class:`cupy.ndarray`): Bias variable (optional) of shape
				:math:`(M,)`.
		Returns:
			~chainer.Variable: Output variable. A float array with shape
			of :math:`(s_B, M)`.
		.. seealso:: :class:`~chainer.links.Linear`
		.. admonition:: Example
			>>> x = np.random.uniform(0, 1, (3, 4)).astype('f')
			>>> W = np.random.uniform(0, 1, (5, 4)).astype('f')
			>>> b = np.random.uniform(0, 1, (5,)).astype('f')
			>>> y = F.linear(x, W, b)
			>>> y.shape
			(3, 5)
	**/
	static public function linear(x:Dynamic, W:Dynamic, ?b:Dynamic) : Dynamic;
}