package chainer.optimizer;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.optimizer', 'UpdateRule') extern class UpdateRule {
	/**
		Base class of all update rules.
		Update rule is an object that implements how to update one parameter
		variable using the gradient of a loss function. This class provides the
		interface and the common features of any update rules.
		An update rule can be set to a :class:`~chainer.Variable` object that
		represents a parameter array of a model. An :class:`~chainer.Optimizer`
		instance defines which parameters to update, and the update rule instance
		of each parameter defines how to update it.
		Hook functions can be set to any update rule instance. The hook function is
		called just before any updates in the order of registrations.
		An implementation of update rule should override :meth:`update_core` or
		its device-dependent variants (i.e., :meth:`update_core_cpu` and
		:meth:`update_core_gpu`).
		The state (e.g. a moving average of the gradient) of the update rule is
		stored into the state dictionary. An implementation of update rule using
		state should also override :meth:`init_state` to initialize the state at
		the first update. The values of the state dictionary are automatically
		copied to the appropriate device before the update based on the data and
		grad arrays.
		Args:
			parent_hyperparam (Hyperparameter): Hyperparameter that provides the
				default values.
		Attributes:
			enabled (bool): Flag to configure if this update rule is active. If the
				update rule is not active (i.e., ``enabled = False``), the
				:meth:`update` method does not update the parameter.
			hyperparam (Hyperparameter): Hyperparameter of the update rule.
			~UpdateRule.t (int): Number of updates made by this update rule.
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
	public function ___init__(?parent_hyperparam:Dynamic) : Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(?parent_hyperparam:Dynamic) : Void;
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
	public function _prepare(param:Dynamic) : Dynamic;
	/**
		Adds a hook function.
        The hook function is called before any updates.
        Args:
            hook (callable): Hook function to be added. It takes two
                arguments: the update rule object and the parameter variable.
            name (str): Name of the hook function. The name attribute of the
                hook function is used by default.
	**/
	public function add_hook(hook:Dynamic, ?name:Dynamic) : Dynamic;
	/**
		Initializes the state.
		Any implementations that use the state should override this mehtod.
		This method is called at the first update.
		Args:
			param (~chainer.Variable): Parameter variable. It can be used to
				extract the shape and the data type of the parameter.

	**/
	public function init_state(param:Dynamic) : Dynamic;
	/**
		Removes the specified hook function.
		Args:
			name (str): Name of the hook function to be removed. The hook
				function registered with this name will be removed.
	**/
	public function remove_hook(name:Dynamic) : Dynamic;
	/**
		Serializes the update rule state.
		Be careful that this method only saves/loads the state of the update
		rule. The parameters of the target link is not saved/loaded by this
		method, and so you need to serialize the target link separately if you
		want to fully recover the training state including parameters.
		Args:
			serializer (~chainer.AbstractSerializer): Serializer object.
	**/
	public function serialize(serializer:Dynamic) : Dynamic;
	/**
		State dictionary.
	**/
	public var state : Dynamic;
	/**
		Invokes hook functions and updates the parameter.
        Args:
            param (~chainer.Variable): Variable to be updated.
	**/
	public function update(param:Dynamic) : Dynamic;
	/**
		Updates the parameter.
        Implementation of UpdateRule should override this method or both of
        :meth:`_update_core_cpu` and :meth:`_update_core_gpu`.
        Args:
            param (~chainer.Variable): Variable to be updated.
	**/
	public function update_core(param:Dynamic) : Dynamic;
	/**
		Updates the parameter on CPU.
        See :meth:`update_core` for details.
        Args:
            param (~chainer.Variable): Variable to be updated.
	**/
	public function update_core_cpu(param:Dynamic) : Dynamic;
	/**
		Updates the parameter on GPU.
        See :meth:`update_core` for details.
        Args:
            param (~chainer.Variable): Variable to be updated.
	**/
	public function update_core_gpu(param:Dynamic) : Dynamic;
}