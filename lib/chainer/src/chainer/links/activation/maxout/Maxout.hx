package chainer.links.activation.maxout;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.links.activation.maxout', 'Maxout') extern class Maxout {
	/**
		Fully-connected maxout layer.
		Let ``M``, ``P`` and ``N`` be an input dimension, a pool size,
		and an output dimension, respectively.
		For an input vector :math:`x` of size ``M``, it computes
		.. math::
		  Y_{i} = \\mathrm{max}_{j} (W_{ij\\cdot}x + b_{ij}).
		Here :math:`W` is a weight tensor of shape ``(M, P, N)``,
		:math:`b` an  optional bias vector of shape ``(M, P)``
		and :math:`W_{ij\\cdot}` is a sub-vector extracted from
		:math:`W` by fixing first and second dimensions to
		:math:`i` and :math:`j`, respectively.
		Minibatch dimension is omitted in the above equation.
		As for the actual implementation, this chain has a
		Linear link with a ``(M * P, N)`` weight matrix and
		an optional ``M * P`` dimensional bias vector.
		Args:
			in_size (int): Dimension of input vectors.
			out_size (int): Dimension of output vectors.
			pool_size (int): Number of channels.
			initialW (:ref:`initializer <initializer>`): Initializer to
				initialize the weight. When it is :class:`numpy.ndarray`,
				its ``ndim`` should be 3.
			initial_bias (:ref:`initializer <initializer>`): Initializer to
				initialize the bias. If ``None``, the bias is omitted.
				When it is :class:`numpy.ndarray`, its ``ndim`` should be 2.
		Attributes:
			linear (~chainer.Link): The Linear link that performs
				affine transformation.
		.. seealso:: :func:`~chainer.functions.maxout`
		.. seealso::
			 Goodfellow, I., Warde-farley, D., Mirza, M.,
			 Courville, A., & Bengio, Y. (2013).
			 Maxout Networks. In Proceedings of the 30th International
			 Conference on Machine Learning (ICML-13) (pp. 1319-1327).
			 `URL <http://jmlr.org/proceedings/papers/v28/goodfellow13.html>`_
	**/

	/**
		Applies the maxout layer.
        Args:
            x (~chainer.Variable): Batch of input vectors.
        Returns:
            ~chainer.Variable: Output of the maxout layer.
	**/
	public function __call__(x:Dynamic) : Dynamic;
	static public function __class__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Implement delattr(self, name).
	**/
	public function __delattr__(name:Dynamic):Dynamic;
	static public var __dict__ : Dynamic;
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
	public function ___init__(in_size:Dynamic, out_size:Dynamic, pool_size:Dynamic, ?initialW:Dynamic, ?initial_bias:Dynamic):Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(in_size:Dynamic, out_size:Dynamic, pool_size:Dynamic, ?initialW:Dynamic, ?initial_bias:Dynamic):Void;
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
	public function add_link(name:Dynamic, link:Dynamic) : Dynamic
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
		Serializes the link object.
        Args:
            serializer (~chainer.AbstractSerializer): Serializer object.
	**/
	public function serialize(serializer:Dynamic) : Dynamic;
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
	@:deprecated public function zerograds() : Dynamic;
}