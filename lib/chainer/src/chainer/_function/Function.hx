package chainer._function;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.function', 'Function') extern class Function {
	/**
		Old-style interface of a differentiable function.

		This class provides an interface to implement an old-style differentiable
		function (i.e., the function application is recorded to the computational
		graph). The subclass of :class:`Function` that implement :meth:`forward`
		and :meth:`backward` can be used to run the forward computation and
		automatically induce the backpropagation procedure.

		There is another way to implement such a function: subclassing
		:class:`~chainer.FunctionNode`. There are mainly two
		differences between them.

		1. The *differentiable backprop* is available for
		   :class:`~chainer.FunctionNode`,
		   while it is not for :class:`Function` because the :meth:`backward`
		   of the latter directly operates on the arrays instead of
		   :class:`Variable` objects so that it cannot record the history of
		   the computation.
		2. The information passed to :meth:`backward` is different. In
		   :class:`~chainer.FunctionNode`,
		   which inputs the function node has to compute
		   the gradients w.r.t. is passed so that it can omit unnecessary
		   computations, while :class:`Function` always has to compute gradients
		   w.r.t. all the input nodes.
		   The :class:`~chainer.FunctionNode` also accepts the
		   current gradient values of the input nodes so that the accumulation
		   work can be merged with the gradient computation if an efficient kernel
		   is available.

		This class uses :class:`~chainer.FunctionAdapter` to convert
		the interface to that of :class:`~chainer.FunctionNode` and
		adds the :class:`~chainer.FunctionNode` object to the
		computational graph.

		See :class:`~chainer.FunctionNode` for the details of
		building the computational graph in Chainer.
	**/

	public function __call__(?inputs:python.VarArgs<Dynamic>):Dynamic;
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
	public function ___init__():Dynamic;
	public function __init_subclass__() : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new():Void;
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
	
	static public var _node : Dynamic;
	static public var _owned_node : Dynamic;
	/**
		Checks types of input data before forward propagation.

        Before :meth:`forward` is called, this function is called.
        You need to validate types of input data in this function
        using :ref:`the type checking utilities <type-check-utils>`.

        Args:
            in_types (~chainer.utils.type_check.TypeInfoTuple): The type
                information of input data for :meth:`forward`.
	**/
	public function check_type_forward(in_types:Dynamic) : Dynamic;
	/**
		Applies forward propagation to input arrays.

        It delegates the procedure to :meth:`forward_cpu` or
        :meth:`forward_gpu` by default. Which it selects is determined by the
        type of input arrays.
        Implementations of :class:`Function` must implement either CPU/GPU
        methods or this method.

        Args:
            inputs: Tuple of input array(s).

        Returns:
            Tuple of output array(s).

        .. warning::

            Implementations of :class:`Function` must take care that the
            return value must be a tuple even if it returns only one array.
	**/
	public function forward(inputs:Dynamic) : Dynamic;
	/**
		Applies forward propagation to input arrays on CPU.

        Args:
            inputs: Tuple of :class:`numpy.ndarray` object(s).

        Returns:
            tuple: Tuple of :class:`numpy.ndarray` object(s).

        .. warning::

            Implementations of :class:`Function` must take care that the
            return value must be a tuple even if it returns only one array.
	**/
	public function forward_cpu(inputs:Dynamic) : Dynamic;
	/**
		Applies forward propagation to input arrays on GPU.

        Args:
            inputs: Tuple of :class:`cupy.ndarray` object(s).

        Returns:
            tuple: Tuple of :class:`cupy.ndarray` object(s).

        .. warning::

            Implementations of :class:`Function` must take care that the
            return value must be a tuple even if it returns only one array.
	**/
	public function forward_gpu(inputs:Dynamic) : Dynamic;
	/**
		Applies backprop to output gradient arrays.

        It delegates the procedure to :meth:`backward_cpu` or
        :meth:`backward_gpu` by default. Which it selects is determined by the
        type of input arrays and output gradient arrays. Implementations of
        :class:`Function` must implement either CPU/GPU methods or this method,
        if the function is intended to be backprop-ed.

        Args:
            inputs: Tuple of input arrays.
            grad_outputs: Tuple of output gradient arrays.

        Returns:
            tuple: Tuple of input gradient arrays. Some or all of them can be
            ``None``, if the function is not differentiable on
            inputs.

        .. warning::

            Implementations of :class:`Function` must take care that the
            return value must be a tuple even if it returns only one array.
	**/
	public function backward(inputs:Dynamic, grad_outputs:Dynamic) : Dynamic;
	/**
		Applies backprop to output gradient arrays on CPU.

        Args:
            inputs: Tuple of input :class:`numpy.ndarray` object(s).
            grad_outputs: Tuple of output gradient :class:`numpy.ndarray`
                object(s).

        Returns:
            tuple: Tuple of input gradient :class:`numpy.ndarray` object(s).
            Some or all of them can be ``None``, if the function is not
            differentiable on corresponding inputs.

        .. warning::

            Implementations of :class:`Function` must take care that the
            return value must be a tuple even if it returns only one array.
	**/
	public function backward_cpu(inputs:Dynamic, grad_outputs:Dynamic) : Dynamic;
	/**
		Applies backprop to output gradient arrays on GPU.

        Args:
            inputs: Tuple of input :class:`cupy.ndarray`
                object(s).
            grad_outputs: Tuple of output gradient
                :class:`cupy.ndarray` object(s).

        Returns:
            tuple: Tuple of input gradient :class:`cupy.ndarray`
            object(s). Some or all of them can be ``None``, if the function is
            not differentiable on corresponding inputs.

        .. warning::

            Implementations of :class:`Function` must take care that the
            return value must be a tuple even if it returns only one array.
	**/
	public function backward_gpu(inputs:Dynamic, grad_outputs:Dynamic) : Dynamic;
	/**
		Purges in/out nodes and this function itself from the graph.

        See :meth:`FunctionNode.unchain() <chainer.FunctionNode.unchain>`
        for the detail.
	**/
	public function unchain() : Dynamic;
	/**
		Registers a function hook.

        See :meth:`FunctionNode.add_hook` for the detail.

        Args:
            hook(~chainer.FunctionHook):
                Function hook to be registered.
            name(str): Name of the function hook.
                name must be unique among function hooks
                registered to the function. If ``None``,
                default name of the function hook is used.
	**/
	public function add_hook(hook:Dynamic, ?name:Dynamic) : Dynamic;
	/**
		Unregisters the specified function hook.

        Args:
            name(str): the name of the function hook
                to be unregistered.
	**/
	public function delete_hook(name:Dynamic) : Dynamic;
	/**
		Lets specified input variable nodes keep data arrays.

        By calling this method from :meth:`forward`, the function can specify
        which inputs are required for backprop.

        If this method is not called, the function keeps all input arrays. If
        you want to release all input arrays, call this method by passing an
        empty sequence. *Note that this behavior is different from that of*
        :meth:`FunctionNode.retain_inputs() \
        <chainer.FunctionNode.retain_inputs>`.

        Note that **this method must not be called from the outside of**
        :meth:`forward`.

        Args:
            indexes (iterable of int): Indexes of input variables that the
                function will require for backprop.
	**/
	public function retain_inputs(indexes:Dynamic) : Dynamic;
	/**
		Lets specified output variable nodes keep data arrays.

        By calling this method from :meth:`forward`, the function can specify
        which outputs are required for backprop. If this method is not called,
        any output variables are not marked to keep the data array at the point
        of returning from :meth:`__call__`. The retained arrays are stored to
        :attr:`output_data`.

        .. note::
           It is STRONGLY RECOMMENDED to use this method if the function
           requires some or all output arrays in backprop. The function can
           also use output arrays just by keeping references to them directly,
           whereas it might influence on the performance of later function
           applications to the output variables.

        Note that **this method must not be called from the outside of**
        :meth:`forward`.

        Args:
            indexes (iterable of int): Indexes of input variables that the
                function will require for backprop.

            retain_after_backward (bool): This option has no effect. It is
                left only for the backward compatibility.
	**/
	public function retain_outputs(indexes:Dynamic, ?retain_after_backward:Dynamic) : Dynamic;
	/**
		The input nodes of the function.
	**/
	public var inputs : Dynamic;
	/**
		Weak references to the output nodes of the function.
	**/
	public var outputs : Dynamic;
	/**
		The :class:`FunctionAdapter` object that wraps this Function.

        If the Function does not have a node object, this property
        automatically creates a new one.
	**/
	public var node : Dynamic;
	/**
		Ordered Dictionary of registered function hooks.

        See :attr:`FunctionNode.local_function_hooks` for the detail.
	**/
	public var local_function_hooks : Dynamic;
	/**
		Short text that represents the function.

        The default implementation returns its type name.
        Each function should override it to give more information.
	**/
	public var label : Dynamic;
	/**
		A tuple of the retained output arrays.

        It has the same length as the :attr:`outputs`. Elements that are not
        retained are set to ``None``.
	**/
	public var output_data : Dynamic;
	/**
		The topological ordinal of the corresponding function node.
	**/
	public var rank : Dynamic;
	/*
		
	**/
	public var stack : Dynamic;
}