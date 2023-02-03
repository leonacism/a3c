package chainer.variable;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.variable', 'Variable') extern class Variable {
	/**
		__init__(data=None, *, name=None, grad=None, requires_grad=True)
		Array with a structure to keep track of computation.
		Every variable holds a data array of type either :class:`numpy.ndarray` or
		:class:`cupy.ndarray`.
		A variable object holds a data array and a
		:class:`~chainer.variable.VariableNode` object of
		a computational graph. If the variable is constructed by the user, the node
		is *root* and does not hold any parent. If the variable is constructed by a
		:class:`~chainer.FunctionNode` object, the node holds a reference to its
		parent called :attr:`creator_node`.
		This reference is used in backpropagation to backtrack the graph.
		Users can disable (resp. enable) this chaining behavior by calling
		:func:`~chainer.no_backprop_mode` (resp.
		:func:`~chainer.force_backprop_mode`).
		In the former context, a variable never creates a computational graph,
		whereas in the latter context, it is forced to create.
		.. warning::
		   ``volatile`` argument is not supported anymore since v2.
		   Instead, use :func:`chainer.no_backprop_mode`.
		Args:
			data (numpy.ndarray or cupy.ndarray): Initial data array.
			name (str): Name of the variable.
			grad (numpy.ndarray or cupy.ndarray): Initial gradient array.
			requires_grad (bool): Boolean indicating whether ``grad`` will be set
				in backward calculation.
	**/

	public function __abs__() : Dynamic;
	public function __add__(rhs:Dynamic) : Dynamic;
	static public var __array_priority__ : Dynamic;
	public function __bool__() : Dynamic;
	static public function __class__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	public function __copy__() : Dynamic;
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
	public function __div__(rhs:Dynamic) : Dynamic;
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
	static public function __getitem__(x:Dynamic, slices:Dynamic) : Dynamic;
	/**
		Return self>value.
	**/
	public function __gt__(value:Dynamic):Dynamic;
	@:native('__hash__') 
	static public var ___hash__ : Dynamic;
	/**
		Return hash(self).
	**/
	public function __hash__() : Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	@:native("__init__")
	public function ___init__(?data:Dynamic, ?kwargs:python.KwArgs<Dynamic>) : Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(?data:Dynamic, ?kwargs:python.KwArgs<Dynamic>) : Void;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	/**
		Returns the first dimension of the data array.
        Returns:
            int: Number of the first dimension of the data array.
	**/
	public function __len__():Dynamic;
	/**
		Return self<value.
	**/
	public function __lt__(value:Dynamic):Dynamic;
	public function __matmul__(rhs:Dynamic) : Dynamic;
	static public var __module__ : Dynamic;
	/**
		Return self!=value.
	**/
	public function __ne__(value:Dynamic):Dynamic;
	public function __neg__():Dynamic;
	/**
		Create and return a new object.  See help(type) for accurate signature.
	**/
	static public function __new__(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	public function __nonzero__() : Dynamic;
	public function __pos__() : Dynamic;
	public function __pow__(rhs:Dynamic) : Dynamic;
	public function __radd__(rhs:Dynamic) : Dynamic;
	public function __rdiv__(rhs:Dynamic) : Dynamic;
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
	public function __rmatmul__(rhs:Dynamic) : Dynamic;
	public function __rmul__(rhs:Dynamic) : Dynamic;
	public function __rpow__(rhs:Dynamic) : Dynamic;
	public function __rsub__(rhs:Dynamic) : Dynamic;
	public function __rtruediv__(rhs:Dynamic) : Dynamic;
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
	public function __sub__(rhs:Dynamic):Dynamic;
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
	public function __truediv__(rhs:Dynamic):Dynamic;
	public var __weakref__ : Dynamic;
	public function _backward_main(retain_grad:Dynamic) : Dynamic;
	public function _copy_to_(target:Dynamic) : Dynamic;
	/**
		Accumulates the gradient array from given source variable.
        This method adds the gradient of a given variable to the gradient of
        this variable. The accumulation is even done across the host and
        different devices. If this variable has uninitialized data/grad arrays,
        this method initializes it with the shape of the given variable and
        then accumulates the gradient.
        Args:
            var (Variable): Source variable.
	**/
	public function addgrad(_var:Dynamic) : Dynamic;
	/**
		The underlying data array.
        It is either :class:`numpy.ndarray` or :class:`cupy.ndarray` object,
        or ``None`` if the variable in in an uninitialized state.
	**/
	public var array : Dynamic;
	/**
		Runs error backpropagation (a.k.a.\\  backprop) from this variable.
        On backprop,
        :meth:`FunctionNode.backward() <chainer.FunctionNode.backward>`
        is called on each :class:`~chainer.FunctionNode` object appearing in
        the backward graph starting from this variable.
        The backward graph is represented by backward
        references from variable nodes to their creators, and from function
        nodes to their input variable nodes. The backprop stops at all root
        nodes. Some function nodes set ``None`` as gradients of some inputs,
        where further backprop does not take place at such inputs.
        This method uses :data:`grad` as the initial error array. User can
        manually set a gradient array before calling this method. If
        :data:`data` contains only one element (i.e., it is scalar) and
        :data:`grad` is ``None``, then this method automatically complements
        1.0 as the initial error. This is useful on starting backprop from
        some scalar loss value.
        From v3, this method supports *differentiable backprop* (a.k.a. double
        backprop, grad of grads). To enable it, pass
        ``enable_double_backprop=True``.
        Args:
            retain_grad (bool): If ``True``, the gradient arrays of all
                intermediate variables are kept.
                Otherwise, :data:`~chainer.Variable.grad` of the
                intermediate variables are set to ``None`` on appropriate
                timing, which may reduce the maximum memory consumption.
                In most cases of training some models, the purpose of backprop
                is to compute gradients of parameters, not of all variables,
                and therefore it is recommended to set this flag ``False``.
            enable_double_backprop (bool): *(Added in v3.0)* If ``True``,
                computational trace of the whole backpropagation procedure is
                recorded to the computational graph so that one can further do
                backpropagation from the resulting gradients. Note that
                enabling it results in larger memory consumption needed to
                store the gradients w.r.t intermediate variables that are
                required for the second gradient computation.

	**/
	public function backward(?retain_grad:Dynamic, ?enable_double_backprop:Dynamic) : Dynamic;
	/**
		Clears the gradient array.
	**/
	public function cleargrad() : Dynamic;
	/**
		Copies the data array from given source variable.
        This method copies the data array from given variable to this variable.
        The copy is done even if the arrays reside on different devices,
        including across the host and a GPU device. If this variable has an
        uninitialized data array, this method initializes it by the data array
        of the given variable. Similarly, if the given variable has an
        uninitialized data array, this method initializes it by the data array
        of this variable (``self``). If both are uninitialized, this method
        does nothing.
        Args:
            var (Variable): Source variable.
	**/
	public function copydata(_var:Dynamic) : Dynamic;
	/**
		Function implementation that created this variable.
        When this variable has been created by an old-style function (i.e., it
        is implemented as a subclass of :class:`Function`), this property
        returns that :class:`Function` object.
        When this variable has been created by a new-style function (i.e., it
        is implemented as a subclass of :class:`FunctionNode` class), this
        property returns that node object.
	**/
	public var creator : Dynamic;
	/**
		:class:`FunctionNode` object that created this variable.
        This property has a setter to which ``None`` can be set. Setting
        ``None`` to this property is equivalent to call :meth:`unchain`;
        it purges the variable from the function that created this variable.
        The setter also accepts the original :class:`FunctionNode` object that
        created this variable. For example, you can once set ``None`` to this
        property and then set the original value again.
        .. note::
           Setting an irrelevant :meth:`FunctionNode` object does not emit any
           error immediately, whereas the behavior is undefined. Do not set
           a :meth:`FunctionNode` object that did not create this variable
           object.
	**/
	public var creator_node : Dynamic;
	/**
		The underlying data array (equivalent to :attr:`array`).
        Note that using this attribute directly is discouraged; use
        :attr:`array` instead. Using :attr:`array`, you can find an error
        earlier when your code mixes up Variable and ndarray because
        ndarray does not have an attribute ``.array`` while it has
        ``.data``.
	**/
	public var data : Dynamic;
	/**
		Display a summary of the stored data and location of the Variable
	**/
	public function debug_print() : Dynamic;
	/**
		
	**/
	public var dtype : Dynamic;
	/**
		Gradient array of this variable.
        Note that this property returns the underlying array of the gradient
        variable instead of the gradient variable itself; to get/set
        gradient variable, use :attr:`grad_var` instead.
	**/
	public var grad : Dynamic;
	/**
		Gradient variable.
	**/
	public var grad_var : Dynamic;
	/**
		Short text that represents the variable.
	**/
	public var label : Dynamic;
	public var name : Dynamic;
	/**
		
	**/
	public var ndim : Dynamic;
	/**
		
	**/
	public var node : Dynamic;
	/**
		
	**/
	public var rank : Dynamic;
	/**
		It indicates that ``grad`` will be set in backward calculation.
	**/
	public var requires_grad : Dynamic;
	/**
		Returns a variable of a different shape and the same content.
        .. seealso::
           :func:`chainer.functions.reshape` for full documentation,
	**/
	public function reshape(?shape:python.VarArgs<Dynamic>) : Dynamic;
	/**
		Lets the corresponding variable node keep the underlying array.
	**/
	public function retain_data() : Dynamic;
	/**
		Notifies the variable that the given function is its creator.
        Args:
            gen_func (Function): Function object that creates this variable as
                one of its outputs.
	**/
	public function set_creator(gen_func:Dynamic) : Dynamic;
	/**
		Notifies the variable that the given node is its creator.
        Args:
            fnode (FunctionNode): Function node that has this variable as an
                output.
	**/
	public function set_creator_node(fnode:Dynamic) : Dynamic;
	/**
		
	**/
	public var shape : Dynamic;
	/**
		
	**/
	public var size : Dynamic;
	public function summary() : Dynamic;
	/**
		Transposition of this variable.
	**/
	public var T : Dynamic;
	/**
		Copies the data and gradient arrays to CPU.
	**/
	public function to_cpu() : Dynamic;
	/**
		Copies the data and gradient arrays to specified GPU.
        Args:
            device: Target device specifier. If omitted, the current device is
                used.
	**/
	public function to_gpu() : Dynamic;
	/**
		Permute the dimensions of an input variable without copy.
        .. seealso::
           :func:`chainer.functions.transpose` for full documentation.
	**/
	public function transpose(?axes:python.VarArgs<Dynamic>) : Dynamic;
	/**
		Deletes the reference to the creator of this variable.
        This method deletes the reference to the creator from the corresponding
        variable node. Unlike :meth:`unchain_backward`, it does not backtrack
        the graph.
        This method is equivalent to ``self.creator_node = None``.
	**/
	public function unchain() : Dynamic;
	/**
		Deletes references between variable nodes and functions backward.
        After this method completes, intermediate variable nodes and functions
        that are not referenced from anywhere are deallocated by reference
        count GC. Also this variable itself deletes the reference to its
        creator function from the node, i.e. the node becomes root in the
        computation graph. It indicates that backprop after unchaining stops at
        this variable. This behavior is useful to implement truncated BPTT.
	**/
	public function unchain_backward() : Dynamic;
	/**
		Initializes the gradient array by zeros.
        Note that the gradient variable is unchained from the computational
        graph by this method because this operation breaks the backprop
        validity.
        .. deprecated:: v1.15
           Use :meth:`cleargrad` instead.
	**/
	@:deprecated public function zerograd() : Dynamic;
}