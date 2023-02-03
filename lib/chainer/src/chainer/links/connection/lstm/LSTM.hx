package chainer.links.connection.lstm;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.links.connection.lstm', 'LSTM') extern class LSTM {
	/**
		Fully-connected LSTM layer.
		This is a fully-connected LSTM layer as a chain. Unlike the
		:func:`~chainer.functions.lstm` function, which is defined as a stateless
		activation function, this chain holds upward and lateral connections as
		child links.
		It also maintains *states*, including the cell state and the output
		at the previous time step. Therefore, it can be used as a *stateful LSTM*.
		This link supports variable length inputs. The mini-batch size of the
		current input must be equal to or smaller than that of the previous one.
		The mini-batch size of ``c`` and ``h`` is determined as that of the first
		input ``x``.
		When mini-batch size of ``i``-th input is smaller than that of the previous
		input, this link only updates ``c[0:len(x)]`` and ``h[0:len(x)]`` and
		doesn't change the rest of ``c`` and ``h``.
		So, please sort input sequences in descending order of lengths before
		applying the function.
		Args:
			in_size (int): Dimension of input vectors. If it is ``None`` or
				omitted, parameter initialization will be deferred until the first
				forward data pass at which time the size will be determined.
			out_size (int): Dimensionality of output vectors.
			lateral_init: A callable that takes ``numpy.ndarray`` or
				``cupy.ndarray`` and edits its value.
				It is used for initialization of the lateral connections.
				May be ``None`` to use default initialization.
			upward_init: A callable that takes ``numpy.ndarray`` or
				``cupy.ndarray`` and edits its value.
				It is used for initialization of the upward connections.
				May be ``None`` to use default initialization.
			bias_init: A callable that takes ``numpy.ndarray`` or
				``cupy.ndarray`` and edits its value
				It is used for initialization of the biases of cell input,
				input gate and output gate.and gates of the upward connection.
				May be a scalar, in that case, the bias is
				initialized by this value.
				If it is ``None``, the cell-input bias is initialized to zero.
			forget_bias_init: A callable that takes ``numpy.ndarray`` or
				``cupy.ndarray`` and edits its value
				It is used for initialization of the biases of the forget gate of
				the upward connection.
				May be a scalar, in that case, the bias is
				initialized by this value.
				If it is ``None``, the forget bias is initialized to one.
		Attributes:
			upward (~chainer.links.Linear): Linear layer of upward connections.
			lateral (~chainer.links.Linear): Linear layer of lateral connections.
			c (~chainer.Variable): Cell states of LSTM units.
			h (~chainer.Variable): Output at the previous time step.
		.. admonition:: Example
			There are several ways to make a LSTM link.
			Let a two-dimensional input array :math:`x` be:
			>>> x = np.zeros((1, 10), dtype=np.float32)
			1. Give both ``in_size`` and ``out_size`` arguments:
				>>> l = L.LSTM(10, 20)
				>>> h_new = l(x)
				>>> h_new.shape
				(1, 20)
			2. Omit ``in_size`` argument or fill it with ``None``:
				The below two cases are the same.
				>>> l = L.LSTM(20)
				>>> h_new = l(x)
				>>> h_new.shape
				(1, 20)
				>>> l = L.LSTM(None, 20)
				>>> h_new = l(x)
				>>> h_new.shape
				(1, 20)
	**/

	/**
		Updates the internal state and returns the LSTM outputs.
        Args:
            x (~chainer.Variable): A new batch from the input sequence.
        Returns:
            ~chainer.Variable: Outputs of updated LSTM units.
	**/
	public function __call__(x:Dynamic) : Dynamic;
	static public function __class__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Implement delattr(self, name).
	**/
	public function __delattr__(name:Dynamic):Dynamic;
	public var __dict__ : Dynamic;
	/**
		__dir__() -> list
		default dir() implementation
	**/
	public function __dir__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	static public var __doc__ : Dynamic;
	/**
		Return self==value.
	**/
	public function __eq__(value:Dynamic) : Dynamic;
	/**
		default object formatter
	**/
	public function __format__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return self>=value.
	**/
	public function __ge__(value:Dynamic):Dynamic;
	/**
		Return getattr(self, name).
	**/
	public function __getattribute__(name:Dynamic):Dynamic;
	/*
		Equivalent to getattr.
	**/
	public function __getitem__(index:Dynamic) : Dynamic;
	/**
		Return self>value.
	**/
	public function __gt__(value:Dynamic):Dynamic;
	/**
		Return hash(self).
	**/
	public function __hash__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	@:native("__init__")
	public function ___init__(in_size:Dynamic, ?out_size:Dynamic, ?lateral_init:Dynamic, ?upward_init:Dynamic, ?bias_init:Dynamic, ?forget_bias_init:Dynamic):Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(in_size:Dynamic, ?out_size:Dynamic, ?lateral_init:Dynamic, ?upward_init:Dynamic, ?bias_init:Dynamic, ?forget_bias_init:Dynamic):Void;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	/**
		Return self<value.
	**/
	public function __lt__(value:Dynamic):Dynamic;
	static public var __module__ : Dynamic;
	/**
		Return self!=value.
	**/
	public function __ne__(value:Dynamic):Dynamic;
	/**
		Create and return a new object.  See help(type) for accurate signature.
	**/
	static public function __new__(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		helper for pickle
	**/
	public function __reduce__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		helper for pickle
	**/
	public function __reduce_ex__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return repr(self).
	**/
	public function __repr__():Dynamic;
	/**
		Implement setattr(self, name, value).
	**/
	public function __setattr__(name:Dynamic, value:Dynamic):Dynamic;
	/**
		__sizeof__() -> int
		size of object in memory, in bytes
	**/
	public function __sizeof__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return str(self).
	**/
	public function __str__():Dynamic;
	/**
		Abstract classes can override this to customize issubclass().
		
		This is invoked early on by abc.ABCMeta.__subclasscheck__().
		It should return True, False or NotImplemented.  If it returns
		NotImplemented, the normal algorithm is used.  Otherwise, it
		overrides the normal algorithm (and the outcome is cached).
	**/
	static public function __subclasshook__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		list of weak references to the object (if defined)
	**/
	public var __weakref__ : Dynamic;
	public function _initialize_params() : Dynamic;
	/**
		Registers a child link to this chain.
        .. deprecated:: v2.0.0
           Assign the child link directly to an attribute within
           :meth:`~chainer.Chain.init_scope` instead.
           For example, the following code
           .. code-block:: python
              chain.add_link('l1', L.Linear(3, 5))
           can be replaced by the following line.
           .. code-block:: python
              with chain.init_scope():
                  chain.l1 = L.Linear(3, 5)
           The latter is easier for IDEs to keep track of the attribute's
           type.
        Args:
            name (str): Name of the child link. This name is also used as the
                attribute name.
            link (Link): The link object to be registered.
	**/
	public function add_link(name:Dynamic, link:Dynamic) : Dynamic;
	/*
		Registers a parameter to the link.
        .. deprecated:: v2.0.0
           Assign a :class:`~chainer.Parameter` object directly to an
           attribute within :meth:`~chainer.Link.init_scope` instead.
           For example, the following code
           .. code-block:: python
               link.add_param('W', shape=(5, 3))
           can be replaced by the following assignment.
           .. code-block:: python
               with link.init_scope():
                   link.W = chainer.Parameter(None, (5, 3))
           The latter is easier for IDEs to keep track of the attribute's
           type.
        Args:
            name (str): Name of the parameter. This name is also used as the
                attribute name.
            shape (int or tuple of ints): Shape of the parameter array. If it
                is omitted, the parameter variable is left uninitialized.
            dtype: Data type of the parameter array.
            initializer: If it is not ``None``, the data is initialized with
                the given initializer. If it is an array, the data is directly
                initialized by it. If it is callable, it is used as a weight
                initializer. Note that in these cases, ``dtype`` argument is
                ignored.
	**/
	@:deprecated public function add_param(name:Dynamic, ?shape:Dynamic, ?dtype:Dynamic, ?initializer:Dynamic) : Dynamic;
	/**
		Registers a persistent value to the link.
        The registered value is saved and loaded on serialization and
        deserialization. The value is set to an attribute of the link.
        Args:
            name (str): Name of the persistent value. This name is also used
                for the attribute name.
            value: Value to be registered.
	**/
	public function add_persistent(name:Dynamic, value:Dynamic) : Dynamic;
	/**
		Accumulates gradient values from given link.
        This method adds each gradient array of the given link to corresponding
        gradient array of this link. The accumulation is even done across
        host and different devices.
        Args:
            link (Link): Source link object.
	**/
	public function addgrads(link:Dynamic) : Dynamic;
	/**
		Returns a generator of all child links.
        Returns:
            A generator object that generates all child links.
	**/
	public function children() : Dynamic;
	/**
		Clears all gradient arrays.
        This method should be called before the backward computation at every
        iteration of the optimization.
	**/
	public function cleargrads() : Dynamic;
	/**
		Copies the link hierarchy to new one.
        The whole hierarchy rooted by this link is copied. The copy is
        basically shallow, except that the parameter variables are also
        shallowly copied. It means that the parameter variables of copied one
        are different from ones of original link, while they share the data and
        gradient arrays.
        The name of the link is reset on the copy, since the copied instance
        does not belong to the original parent chain (even if exists).
        Returns:
            Link: Copied link object.
	**/
	public function copy() : Dynamic;
	/**
		Copies all parameters from given link.
        This method copies data arrays of all parameters in the hierarchy. The
        copy is even done across the host and devices. Note that this method
        does not copy the gradient arrays.
        Args:
            link (Link): Source link object.
	**/
	public function copyparams(link:Dynamic) : Dynamic;
	/**
		Disables update rules of all parameters under the link hierarchy.
        This method sets the :attr:`~chainer.UpdateRule.enabled` flag of the
        update rule of each parameter variable to ``False``.
	**/
	public function disable_update() : Dynamic;
	/**
		Enables update rules of all parameters under the link hierarchy.
        This method sets the :attr:`~chainer.UpdateRule.enabled` flag of the
        update rule of each parameter variable to ``True``.
	**/
	public function enable_update() : Dynamic;
	/*
		Creates an initialization scope.
        This method returns a context manager object that enables registration
        of parameters (and links for :class:`~chainer.Chain`) by an assignment.
        A :class:`~chainer.Parameter` object can be automatically registered
        by assigning it to an attribute under this context manager.
        .. admonition:: Example
           In most cases, the parameter registration is done in the
           initializer method. Using the ``init_scope`` method, we can
           simply assign a :class:`~chainer.Parameter` object to register
           it to the link.
           .. code-block:: python
              class MyLink(chainer.Link):
                  def __init__(self):
                      super().__init__()
                      with self.init_scope():
                          self.W = chainer.Parameter(0, (10, 5))
                          self.b = chainer.Parameter(0, (5,))
	**/
	public function init_scope() : Dynamic;
	/**
		Returns a generator of all links under the hierarchy.
        Args:
            skipself (bool): If ``True``, then the generator skips this link
                and starts with the first child link.
        Returns:
            A generator object that generates all links.
	**/
	public function links(?skipself:Dynamic) : Dynamic;
	/**
		Returns a generator of all (path, param) pairs under the hierarchy.
        Args:
            include_uninit (bool): If ``True``, it also generates uninitialized
                parameters.
        Returns:
            A generator object that generates all (path, parameter) pairs. The
            paths are relative from this link.
	**/
	public function namedparams(?include_uninit:Dynamic) : Dynamic;
	/**
		Returns a generator of all (path, link) pairs under the hierarchy.
        Args:
            skipself (bool): If ``True``, then the generator skips this link
                and starts with the first child link.
        Returns:
            A generator object that generates all (path, link) pairs.
	**/
	public function namedlinks(?skipself:Dynamic) : Dynamic;
	/**
		Returns a generator of all parameters under the link hierarchy.
        Args:
            include_uninit (bool): If ``True``, it also generates uninitialized
                parameters.
        Returns:
            A generator object that generates all parameters.
	**/
	public function params(?include_uninit:Dynamic) : Dynamic;
	/**
		Registers an attribute of a given name as a persistent value.
        This is a convenient method to register an existing attribute as a
        persistent value. If ``name`` has been already registered as a
        parameter, this method removes it from the list of parameter names
        and re-registers it as a persistent value.
        Args:
            name (str): Name of the attribute to be registered.

	**/
	public function register_persistent(name:Dynamic) : Dynamic;
	/**
		Resets the internal state.
        It sets ``None`` to the :attr:`c` and :attr:`h` attributes.
	**/
	public function reset_state(c:Dynamic, h:Dynamic) : Dynamic;
	/**
		Serializes the link object.
        Args:
            serializer (~chainer.AbstractSerializer): Serializer object.
	**/
	public function serialize(serializer:Dynamic) : Dynamic;
	/**
		Sets the internal state.
        It sets the :attr:`c` and :attr:`h` attributes.
        Args:
            c (~chainer.Variable): A new cell states of LSTM units.
            h (~chainer.Variable): A new output at the previous time step.
	**/
	public function set_state(c:Dynamic, h:Dynamic) : Dynamic;
	/**
		Copies parameter variables and persistent values to CPU.
        This method does not handle non-registered attributes. If some of such
        attributes must be copied to CPU, the link implementation must
        override this method to do so.
        Returns: self
	**/
	public function to_cpu() : Dynamic;
	/**
		Copies parameter variables and persistent values to GPU.
        This method does not handle non-registered attributes. If some of such
        attributes must be copied to GPU, the link implementation must
        override this method to do so.
        Args:
            device: Target device specifier. If omitted, the current device is
                used.
        Returns: self
	**/
	public function to_gpu(?device:Dynamic) : Dynamic;
	/**
		``True`` if at least one parameter has an update rule enabled.
	**/
	public var update_enabled : Dynamic;
	/**
		True if the current code is inside of an initialization scope.
        See :meth:`init_scope` for the details of the initialization scope.
	**/
	public var within_init_scope : Dynamic;
	/**
		Array module for this link.
        Depending on which of CPU/GPU this link is on, this property returns
        :mod:`numpy` or :mod:`cupy`.
	**/
	public var xp : Dynamic;
	/**
		Initializes all gradient arrays by zero.
        This method can be used for the same purpose of cleargrads, but less
        efficient. This method is left for backward compatibility.
        .. deprecated:: v1.15
           Use :meth:`cleargrads` instead.
	**/
	public function zerograds() : Dynamic;
}