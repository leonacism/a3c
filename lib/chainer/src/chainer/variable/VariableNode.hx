package chainer.variable;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.variable', 'VariableNode') extern class VariableNode {
	/**
		Node in the backward computational graph representing a variable.
		This object represents a variable node in a computational graph. The node
		is used in error backpropagation (a.k.a. backprop) to determine which
		gradient to be passed to each function.
		A variable node is held by the corresponding :class:`~chainer.Variable`
		object, which is managed by users. :class:`~chainer.FunctionNode` objects
		that take the variable as an input also hold references to the variable
		node.
		Note that the node does not hold a reference to the corresponding data
		array in general. The data array is actually accessible by the node in the
		following cases.
		1. If there exists a :class:`~chainer.Variable` object that holds a
		   reference to the variable node, the variable node holds a weak reference
		   to the variable object, and thus the data array is accessible via the
		   weak reference.
		2. If :meth:`retain_data` is called, the node holds a reference to the data
		   array. It is mainly called by a function that needs the input or output
		   data array in its backprop procedure.
		   See :meth:`FunctionNode.retain_inputs()
		   <chainer.FunctionNode.retain_inputs>`
		   and :meth:`FunctionNode.retain_outputs()
		   <chainer.FunctionNode.retain_outputs>` for more details.
		Users usually do not need to touch this variable node object. The
		computational graph is automatically managed by Chainer, and any interface
		that is beneficial for users is also provided by
		:class:`~chainer.Variable`.
		Args:
			variable (Variable): The corresponding variable object.
			name (str): Name of the variable node.
		Attributes:
			~VariableNode.dtype: Data type of the data array.
			~VariableNode.shape: Shape of the data array.
			~VariableNode.name (str): Name of the variable node.
	**/

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
	public function ___init__(variable:Dynamic, name:Dynamic, ?kwargs:python.KwArgs<Dynamic>) : Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(variable:Dynamic, name:Dynamic, ?kwargs:python.KwArgs<Dynamic>) : Void;
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
	public function _check_old_style_gradient() : Dynamic;
	static public var _creator_node : Dynamic;
	static public var _data : Dynamic;
	static public var _old_style_grad_generator : Dynamic;
	static public var _rank : Dynamic;
	public function _update_data_info(d:Dynamic) : Dynamic;
	/**
		Function object that created this variable node.
        When the function is implemented with the old-style API (i.e., it uses
        :class:`~chainer.Function` class),
        this property returns the :class:`~chainer.Function` object.
        The object is extracted from the :class:`~chainer.FunctionAdapter`
        object, so the returned object is not the function node, but instead
        the actual implementation of forward and backward procedures.
        When the function is implemented with the new-style API (i.e., it uses
        :class:`~chainer.FunctionNode` class),
        this property returns the function node
        object. In this case, the returned object is same as
        :attr:`creator_node`.
        .. warning::
           As of v3.0.0, when the creator is an old-style function, the
           following code is invalid:
           .. code-block:: python
              creator = v.creator
              v.creator = None
              ...
              v.creator = creator
           The point is that :class:`~chainer.FunctionNode` objects are used
           as nodes in the computational graph instead of
           :class:`~chainer.Function`, and each :class:`~chainer.Function`
           object only holds a *weak reference* to the corresponding
           :class:`~chainer.FunctionNode`.
           Since ``creator`` returns the :class:`~chainer.Function` object,
           the :class:`~chainer.FunctionNode` object is not kept by preserving
           ``creator``.
           The above code should be fixed as follows.
           .. code-block:: python
              creator_node = v.creator_node
              v.creator_node = None
              ...
              v.creator_node = creator_node
	**/
	public var creator : Dynamic;
	/**
		Function node that has this variable as an output.
        See :class:`~chainer.FunctionNode` for the definition of a function
        node.
	**/
	public var creator_node : Dynamic;
	/**
		Data array of the corresponding variable.
        If the data is not available, it returns ``None``.
	**/
	public var data : Dynamic;
	/**
		Returns the corresponding :class:`~chainer.Variable` object.
        VariableNode object holds a weak reference of the variable object. If
        the reference is alive, it is returned by this property. Otherwise,
        this property creates a new :class:`~chainer.Variable` object from
        this node object and returns it.
        Returns:
            Variable: The variable object that refers this node.
	**/
	public function get_variable() : Dynamic;
	/**
		Returns the holding :class:`Variable` object or ``None``.
        VariableNode object holds a weak reference of the variable object.If
        the reference is alive, it is returned by this property. Otherwise,
        returns ``None``.
        Returns:
            Variable: The variable object that refers this node.
	**/
	public function get_variable_or_none() : Dynamic;
	/**
		Gradient array of the corresponding variable.
        If the variable is not available, it returns ``None``.
	**/
	public var grad : Dynamic;
	/**
		Gradient variable of the corresponding variable.
        If the corresponding variable is not available, it return ``None``.
	**/
	public var grad_var : Dynamic;
	/**
		Short text that represents the variable node.
	**/
	public var label : Dynamic;
	/**
		
	**/
	public var rank : Dynamic;
	/**
		It indicates that ``grad`` will be set in backward calculation.
	**/
	public var requires_grad : Dynamic;
	/**
		Lets the node hold a reference to the underlying data array.
        This method gets the data array of the corresponding variable and keeps
        it. If the weak reference to the corresponding variable is dead, it
        raises an error.
	**/
	public function retain_data() : Dynamic;
	/**
		Sets a :class:`~chainer.Function` object that created this node.
        This method is equivalent to ``self.creator = creator``. A
        :class:`~chainer.FunctionNode` object can also be passed.
        Args:
            creator (Function or FunctionNode): Function that has created this
                variable.
	**/
	public function set_creator(creator:Dynamic) : Dynamic;
	/**
		Sets a :class:`~chainer.FunctionNode` object that created this node.
        This method is equivalent to ``self.creator_node = creator_node``. A
        :class:`~chainer.Function` object can also be passed, in which case the
        :attr:`Function.node <chainer.Function.node>` attribute is used.
        Args:
            creator_node (FunctionNode or Function): Function node that has
                this variable as an output.
	**/
	public function set_creator_node(creator_node:Dynamic) : Dynamic;
	/**
		Deletes the reference to the creator of this variable node.
        This method is equivalent to ``self.creator_node = None``.
	**/
	public function unchain() : Dynamic;
}