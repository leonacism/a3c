package chainer.optimizer;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.optimizer', 'Optimizer') extern class Optimizer {
	/*
		Base class of all numerical optimizers.
		This class provides basic features for all optimization methods. It
		optimizes parameters of a *target link*. The target link is registered via
		the :meth:`setup` method, and then the :meth:`update` method updates its
		parameters based on a given loss function.
		Each optimizer implementation must be defined as a child class of
		Optimizer. It must override :meth:`update` method.
		If the optimizer is based on single gradient computation (like
		most first-order methods), then it should inherit :class:`GradientMethod`,
		which adds some features dedicated for the first order methods, including
		the support of :class:`~chainer.UpdateRule`.
		Optimizer instance also supports *hook functions*. Hook function is
		registered by the :meth:`add_hook` method. Each hook function is called
		in registration order in advance of the actual parameter update. If the
		hook function has an attribute ``call_for_each_param`` and its value is
		``True``, the hook function is used as a hook function of all update rules
		(i.e., it is invoked for every parameter by passing the corresponding
		update rule and the parameter).
		Attributes:
			~Optimizer.target: Target link object.
				It is set by the :meth:`setup` method.
			~Optimizer.t: Number of update steps. It must be incremented by the
				:meth:`update` method.
			~Optimizer.epoch: Current epoch. It is incremented by the
				:meth:`new_epoch` method.
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
	public function ___init__() : Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new() : Void;
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
	public function _call_hook(hook:Dynamic) : Dynamic;
	static public var _hooks : Dynamic;
	/**
		Registers a hook function.
		Hook function is typically called right after the gradient computation,
		though the timing depends on the optimization method.
		Args:
			hook (function): Hook function. If ``hook.call_for_each_param`` is
				true, this hook function is called for each parameter by
				passing the update rule and the parameter. Otherwise, this hook
				function is called only once each iteration by passing the
				optimizer.
			name (str): Name of the registration. If omitted, ``hook.name`` is
				used by default.
	**/
	public function add_hook(hook:Dynamic, ?name:Dynamic) : Dynamic;
	/**
		Invokes hook functions in registration order.
	**/
	public function call_hooks() : Dynamic;
	static public var epoch : Dynamic;
	/**
		Starts a new epoch.
		This method increments the :attr:`epoch` count. Note that if the
		optimizer depends on the epoch count, then user should call this method
		appropriately at the beginning of each epoch.
	**/
	public function new_epoch() : Dynamic;
	/**
		Removes a hook function.
		Args:
			name (str): Registered name of the hook function to remove.
	**/
	public function remove_hook(name:Dynamic) : Dynamic;
	/**
		Serializes or deserializes the optimizer.
		It only saves or loads the following things:
		- Optimizer states
		- Global states (:attr:`t` and :attr:`epoch`)
		**It does not saves nor loads the parameters of the target link.** They
		should be separately saved or loaded.
		Args:
			serializer (~chainer.AbstractSerializer): Serializer or
				deserializer object.
	**/
	public function serialize(serializer:Dynamic) : Dynamic;
	/**
		Sets a target link and initializes the optimizer states.
        Given link is set to the :attr:`target` attribute. It also prepares the
        optimizer state dictionaries corresponding to all parameters in the
        link hierarchy. The existing states are discarded.
        Args:
            link (~chainer.Link): Target link object.
	**/
	public function setup(link:Dynamic) : Dynamic;
	static public var t : Dynamic;
	static public var target : Dynamic;
	/**
		Updates the parameters.
        This method updates the parameters of the target link. The behavior of
        this method is different for the cases either ``lossfun`` is given or
        not.
        If ``lossfun`` is given, this method typically clears the gradients,
        calls the loss function with given extra arguments, and calls the
        :meth:`~chainer.Variable.backward` method of its output to compute the
        gradients. The actual implementation might call ``lossfun`` more than
        once.
        If ``lossfun`` is not given, then this method assumes that the
        gradients of all parameters are already computed. An implementation
        that requires multiple gradient computations might raise an error on
        this case.
        In both cases, this method invokes the update procedure for all
        parameters.
        Args:
            lossfun (function): Loss function. It accepts arbitrary arguments
                and returns one :class:`~chainer.Variable` object that
                represents the loss (or objective) value. This argument can be
                omitted for single gradient-based methods. In this case, this
                method assumes gradient arrays computed.
            args, kwds: Arguments for the loss function.
	**/
	public function update(?lossfun:Dynamic, ?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>) : Dynamic;
}