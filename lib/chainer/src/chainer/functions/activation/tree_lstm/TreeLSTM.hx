package chainer.functions.activation.tree_lstm;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.functions.activation.tree_lstm', 'TreeLSTM') extern class TreeLSTM {
	/**
		TreeLSTM unit with N forget gates.
		This have variable inputs ``(c1, c2, ..., cN, x)``
		where ``x`` is (3 + N) times larger than each cell.
		Forget gates ``(f1, f2, ..., fN)`` can depend in
		different partitions of ``x[:, 3 * cell_units:]``.
		There are two outputs ``(c, h)``.
	**/

	public function __call__(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>) : Dynamic;
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
	public function _check_data_type_forward(in_data:Dynamic) : Dynamic;
	public var _impl_name : Dynamic;
	static public var _input_indexes_to_retain : Dynamic;
	static public var _local_function_hooks : Dynamic;
	public var _n_local_function_hooks : Dynamic;
	static public var _output_indexes_to_retain : Dynamic;
	static public var _retained_output_data : Dynamic;
	/**
		Registers a function hook.
        Args:
            hook (~chainer.FunctionHook): Function hook to be
                registered.
            name (str): Name of the function hook. The name must be unique
                among function hooks registered to this function. If ``None``,
                the default name of the function hook is used.
	**/
	public function add_hook(hook:Dynamic, ?name:Dynamic) : Dynamic;
	/**
		Computes output variables and grows the computational graph.
        Basic behavior is expressed in the documentation of
        :class:`FunctionNode`.
        .. note::
           If the :data:`~Variable.data` attribute of input variables exist on
           a GPU device, that device is made current before calling
           :meth:`forward`, so implementors do not need to take care of device
           selection in most cases.
        Args:
            inputs: Tuple of input variables. Each element can be either
                :class:`~chainer.Variable`, :class:`numpy.ndarray`,
                or :class:`cupy.ndarray`. If the element is an ndarray, it is
                automatically wrapped with :class:`~chainer.Variable`.
        Returns:
            A tuple of output :class:`~chainer.Variable` objects.
	**/
	public function apply(inputs:Dynamic) : Dynamic;
	/**
		Computes gradients w.r.t.\\  specified inputs given output gradients.
        This method is used to compute one step of the backpropagation
        corresponding to the forward computation of this function node.
        Given the gradients w.r.t. output variables, this method computes the
        gradients w.r.t. specified input variables. Note that this method does
        not need to compute any input gradients not specified by
        ``target_input_indices``.
        Unlike :meth:`Function.backward() <chainer.Function.backward>`,
        gradients are given as  :class:`~chainer.Variable` objects and this
        method itself has to return input gradients as
        :class:`~chainer.Variable` objects. It enables the function node to
        return the input gradients with the full computational history, in
        which case it supports *differentiable backpropagation* or
        *higher-order differentiation*.
        The default implementation returns ``None`` s, which means the
        function is not differentiable.
        Args:
            target_input_indexes (tuple of int): Indices of the input variables
                w.r.t. which the gradients are required. It is guaranteed that
                this tuple contains at least one element.
            grad_outputs (tuple of :class:`~chainer.Variable`\\ s): Gradients
                w.r.t. the output variables.
                If the gradient w.r.t. an output variable is not
                given, the corresponding element is ``None``.
        Returns:
            Tuple of variables that represent the gradients w.r.t. specified
            input variables. The length of the tuple can be same as either
            ``len(target_input_indexes)`` or the number of inputs. In the
            latter case, the elements not specified by ``target_input_indexes``
            will be discarded.
        .. seealso::
           :meth:`backward_accumulate` provides an alternative interface that
           allows you to implement the backward computation fused with the
           gradient accumulation.
	**/
	public function backward(inputs:Dynamic, grad_outputs:Dynamic) : Dynamic;
	/**
		Computes gradients w.r.t.\\  specified inputs and accumulates them.
        This method provides a way to fuse the backward computation and the
        gradient accumulations in the case that the multiple functions are
        applied to the same variable.
        Users have to override either of this method or :meth:`backward`.
        It is often simpler to implement :meth:`backward` and is recommended
        if you do not need to provide efficient gradient accumulation.
        Args:
            target_input_indexes (tuple of int): Indices of the input variables
                w.r.t. which the gradients are required. It is guaranteed that
                this tuple contains at least one element.
            grad_outputs (tuple of Variable): Gradients w.r.t. the output
                variables. If the gradient w.r.t. an output variable is not
                given, the corresponding element is ``None``.
            grad_inputs (tuple of Variable): Gradients w.r.t. the input
                variables specified by ``target_input_indexes``. These values
                are computed by other computation paths. If there is no
                gradient value existing for the variable, the corresponding
                element is ``None``. See also the note below.
        Returns:
            Tuple of variables that represent the gradients w.r.t. specified
            input variables. Unlike :meth:`backward`, the length of the tuple
            **must** be same as that of ``target_input_indices``.
        .. note::
           When the same variable is passed to the multiple input arguments of
           a function, only the first position of ``grad_inputs`` corresponding
           to these input arguments may contain the gradient variable
           corresponding to that input variable, and other entries are set to
           ``None``. This is an implementation-detail convention to avoid the
           complication of correctly accumulating gradients in such a case.
           This behavior might be changed in a future version.
	**/
	public function backward_accumulate(target_input_indexes:Dynamic, grad_outputs:Dynamic, grad_inputs:Dynamic) : Dynamic;
	/**
		Checks types of input data before forward propagation.
        This method is called before :meth:`forward` and validates the types of
        input variables using
        :ref:`the type checking utilities <type-check-utils>`.
        Args:
            in_types (~chainer.utils.type_check.TypeInfoTuple): The type
                information of input variables for :meth:`forward`.
	**/
	public function check_type_forward(in_types:Dynamic) : Dynamic;
	/**
		Unregisters the function hook.
        Args:
            name (str): The name of the function hook to be unregistered.
	**/
	public function delete_hook(name:Dynamic) : Dynamic;
	/**
		Computes the output arrays from the input arrays.
        It delegates the procedure to :meth:`forward_cpu` or
        :meth:`forward_gpu` by default. Which of them this method selects is
        determined by the type of input arrays. Implementations of
        :class:`FunctionNode` must implement either CPU/GPU methods or this
        method.
        Args:
            inputs: Tuple of input array(s).
        Returns:
            Tuple of output array(s).
        .. warning::
            Implementations of :class:`FunctionNode` must take care that the
            return value must be a tuple even if it returns only one array.
	**/
	public function forward(inputs:Dynamic) : Dynamic;
	/**
		Computes the output arrays from the input NumPy arrays.
        Args:
            inputs: Tuple of input :class:`numpy.ndarray` objects.
        Returns:
            Tuple of output arrays. Each element can be NumPy or CuPy arrays.
        .. warning::
            Implementation of :class:`FunctionNode` must take care that the
            return value must be a tuple even if it returns only one array.
	**/
	public function forward_cpu(inputs:Dynamic) : Dynamic;
	/**
		Computes the output arrays from the input CuPy arrays.
        Args:
            inputs: Tuple of input :class:`cupy.ndarray` objects.
        Returns:
            Tuple of output arrays. Each element can be NumPy or CuPy arrays.
        .. warning::
            Implementation of :class:`FunctionNode` must take care that the
            return value must be a tuple even if it returns only one array.
	**/
	public function forward_gpu(inputs:Dynamic) : Dynamic;
	/**
		Returns a tuple of retained input variables.
        This method is used to retrieve the input variables retained in
        :meth:`forward`.
        Returns:
            A tuple of retained input variables.
	**/
	public function get_retained_inputs() : Dynamic;
	/**
		Returns a tuple of retained output variables.
        This method is used to retrieve the output variables retained in
        :meth:`forward`.
        Returns:
            A tuple of retained output variables.
        .. note::
           This method does a tricky thing to support the case of an output
           node garbage-collected before this method is called; in this case,
           this method creates a fresh variable node that acts as an output
           node of the function node.
	**/
	public function get_retained_outputs() : Dynamic;
	static public var inputs : Dynamic;
	public var label : Dynamic;
	public var local_function_hooks : Dynamic;
	public var output_data : Dynamic;
	static public var outputs : Dynamic;
	static public var rank : Dynamic;
	/**
		Lets specified input variable nodes keep data arrays.
        By calling this method from :meth:`forward`, the function node can
        specify which inputs are required for backprop. The input variables
        with retained arrays can then be obtained by calling
        :meth:`get_retained_inputs` from inside :meth:`backward`.
        Unlike :class:`~chainer.Function`, the function node **DOES NOT** keep
        input
        arrays by default. If you want to keep some or all input arrays, do not
        forget to call this method.
        Note that **this method must not be called from the outside of**
        :meth:`forward`.
        Args:
            indexes (iterable of int): Indexes of input variables that the
                function will require for backprop.
	**/
	public function retain_inputs(indexes:Dynamic) : Dynamic;
	/**
		Lets specified output variable nodes keep data arrays.
        By calling this method from :meth:`forward`, the function node can
        specify which outputs are required for backprop. If this method is not
        called, no output variables will be marked to keep their data array at
        the point of returning from :meth:`apply`. The output variables with
        retained arrays can then be obtained by calling
        :meth:`get_retained_outputs` from inside :meth:`backward`.
        .. note::
           It is recommended to use this method if the function requires some
           or all output arrays in backprop. The function can also use output
           arrays just by keeping references to them directly, although it
           might affect the performance of later function applications on the
           output variables.
        Note that **this method must not be called from the outside of**
        :meth:`forward`.
        Args:
            indexes (iterable of int): Indexes of output variables that the
                function will require for backprop.
	**/
	public function retain_outputs(indexes:Dynamic) : Dynamic;
	static public var stack : Dynamic;
	/**
		Purges in/out nodes and this function node itself from the graph.
	**/
	public function unchain() : Dynamic;
}