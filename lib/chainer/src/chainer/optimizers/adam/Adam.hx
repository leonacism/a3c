package chainer.optimizers.adam;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.optimizers.adam', 'Adam') extern class Adam {
	/**
		Adam optimizer.
		See: `Adam: A Method for Stochastic Optimization \
			  <https://arxiv.org/abs/1412.6980v8>`_
		Modified for proper weight decay (also called AdamW).
		AdamW introduces the additional parameters ``eta``
		and ``weight_decay_rate``, which can be used to properly scale the
		learning rate, and decouple the weight decay rate from ``alpha``,
		as shown in the below paper.
		Note that with the default values ``eta = 1`` and
		``weight_decay_rate = 0``, this implementation is identical to
		the standard Adam method.
		See: `Fixing Weight Decay Regularization in Adam \
			  <https://openreview.net/forum?id=rk6qdGgCZ>`_
		A flag ``amsgrad`` to use the AMSGrad variant of Adam from
		the paper: `On the Convergence of Adam and Beyond \
				   <https://openreview.net/forum?id=ryQu7f-RZ>`_
		Args:
			alpha (float): Step size.
			beta1 (float): Exponential decay rate of the first order moment.
			beta2 (float): Exponential decay rate of the second order moment.
			eps (float): Small value for the numerical stability.
			eta (float): Schedule multiplier, can be used for warm restarts.
			weight_decay_rate (float): Weight decay rate.
			amsgrad (bool): Whether to use AMSGrad variant of Adam.
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
	public function ___init__(?alpha:Dynamic, ?beta1:Dynamic, ?beta2:Dynamic, ?eps:Dynamic, ?eta:Dynamic, ?weight_decay_rate:Dynamic, ?amsgrad:Dynamic) : Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(?alpha:Dynamic, ?beta1:Dynamic, ?beta2:Dynamic, ?eps:Dynamic, ?eta:Dynamic, ?weight_decay_rate:Dynamic, ?amsgrad:Dynamic) : Void;
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
	static public var alpha : Dynamic;
	static public var beta1 : Dynamic;
	static public var beta2 : Dynamic;
	/**
		Invokes hook functions in registration order.
	**/
	public function call_hooks() : Dynamic;
	/**
		Creates a new update rule object.
        This method creates an update rule object. It is called by
        :meth:`setup` to set up an update rule of each parameter.
        Each implementation of the gradient method should override this method
        to provide the default update rule implementation.
        Return:
            UpdateRule: Update rule object.
	**/
	public function create_update_rule() : Dynamic;
	static public var epoch : Dynamic;
	static public var eps : Dynamic;
	public var lr : Dynamic;
	/**
		Starts a new epoch.
		This method increments the :attr:`epoch` count. Note that if the
		optimizer depends on the epoch count, then user should call this method
		appropriately at the beginning of each epoch.
	**/
	public function new_epoch() : Dynamic;
	/**
		Reallocate gradients cleared by :meth:`~chainer.Variable.cleargrad`.
        This method allocates arrays for all gradients which have :obj:`None`.
        This method is called before and after every optimizer hook.
        If an inheriting optimizer does not require this allocation,
        the optimizer can override this method with a blank function.
	**/
	public function reallocate_cleared_grads() : Dynamic;
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
		Updates parameters based on a loss function or computed gradients.
        This method runs in two ways.
        - If ``lossfun`` is given, then it is used as a loss function to
          compute gradients.
        - Otherwise, this method assumes that the gradients are already
          computed.
        In both cases, the computed gradients are used to update parameters.
        The actual update routines are defined by the update rule of each
        parameter.
	**/
	public function update(?lossfun:Dynamic, ?args:python.VarArgs<Dynamic>, ?kwds:python.KwArgs<Dynamic>) : Dynamic;
	/**
		Enables or disables use of :func:`~chainer.Link.cleargrads` in `update`.
        Args:
            use (bool): If ``True``, this function enables use of
                `cleargrads`. If ``False``, disables use of `cleargrads`
                (`zerograds` is used).
        .. deprecated:: v2.0
           Note that :meth:`update` calls :meth:`~Link.cleargrads` by default.
           :meth:`~Link.cleargrads` is more efficient than
           :meth:`~Link.zerograds`, so one does not have to call
           :meth:`use_cleargrads`. This method remains for backward
           compatibility.
	**/
	public function use_cleargrads(?use:Dynamic) : Dynamic;
}