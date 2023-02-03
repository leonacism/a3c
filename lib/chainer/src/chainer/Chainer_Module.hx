package chainer;

/**
 * Chainer 3.4.0
 * @author leonaci
 */
@:pythonImport('chainer') extern class Chainer_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __path__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _thread_local : Dynamic;
	/**
		Converts an array or a variable into :class:`~chainer.Variable`.
		This is a convenient function to get a :class:`~chainer.Variable` object
		transparently from a raw array or a variable.
		Note that this function should only be used for type consistency (i.e., to
		enforce the return value of an API having type :class:`~chainer.Varialbe`).
		The :class:`~chainer.Variable.requires_grad` flag is kept as is; if ``obj``
		is a raw array, the newly created variable has ``requires_grad = False``.
		In order to make a variable w.r.t. which you want to compute the gradient,
		you should use :class:`~chainer.Variable` directly.
		Args:
			obj (numpy.ndarray or cupy.ndarray or ~chainer.Variable): An array or
				a variable that you want to convert to :class:`~chainer.Variable`.
		Returns:
			~chainer.Variable:
			A variable converted from ``obj``. If ``obj`` is a raw array, this is a
			new :class:`~chainer.Variable` object that wraps the array. If ``obj``
			is already a :class:`~chainer.Variable` object, this function returns
			``obj`` as is.
	**/
	static public function as_variable(obj:Dynamic) : Dynamic;
	static public var config : Dynamic;
	static public var disable_experimental_feature_warning : Dynamic;
	/**
		Make a context manager which enables back-propagation.

		When you want to enable back-propagation in :func:`no_backprop_mode`, call
		this method. A :class:`~chainer.Variable` created in this context always
		has a computational graph unless overridden by deeper contexts. If you call
		this method outside of :func:`no_backprop_mode` context, it changes
		nothing.

		In the following example, ``y`` has a computational graph and calling
		:func:`~chainer.Variable.backward` on ``y`` will compute and accumulate the
		gradients of the variables in the graph, in this case only ``x``.

		>>> x = chainer.Variable(np.array([1,], 'f'))
		>>> with chainer.no_backprop_mode():
		...     with chainer.force_backprop_mode():
		...         y = x + 1
		>>> y.backward()
		>>> x.grad
		array([1.], dtype=float32)

		.. seealso::

		   See :func:`no_backprop_mode` for details on disabled back-propagation
		   mode.
	**/
	static public function force_backprop_mode() : Dynamic;	static public function get_current_reporter() : Dynamic;
	static public function get_function_hooks() : Dynamic;
	/**
		Global configuration of Chainer.

		It is an instance of :class:`chainer.configuration.GlobalConfig`.
		See :ref:`configuration` for details.
		'''


		config = LocalConfig(global_config)
		'''Thread-local configuration of Chainer.

		It is an instance of :class:`chainer.configuration.LocalConfig`, and is
		referring to :data:`~chainer.global_config` as its default configuration.
		See :ref:`configuration` for details.
	**/
	static public var global_config : Dynamic;
	/**
		Computes the gradient of output variables w.r.t.\\  the input variables.

		This function implements the backpropagation algorithm. While
		:meth:`Variable.backward` also implements backprop, this function selects
		the smallest paths in the computational graph needed to compute the
		gradients w.r.t. inputs. The error is backpropagated only through these
		selected paths, which may reduce the overall computational cost.

		This function also differs from :meth:`Variable.backward` in the way to
		return the gradients; it directly returns the gradient variables as a list
		instead of setting gradients to the :attr:`Variable.grad_var` attribute of
		the original variable. It means users do not need to clear the gradient
		w.r.t. each variable before computing the gradient using this function.
		If ``set_grad`` option is set to ``True``, the computed gradient is also
		stored in the :attr:`Variable.grad_var` attribute of each variable, in
		which case any original value of :attr:`Variable.grad_var` will be updated
		even if it had already been set.

		Args:
			outputs (tuple or list of :class:`~chainer.Variable`):
				A sequence of output variables from which backprop starts.
			inputs (tuple or list of :class:`~chainer.Variable`):
				A sequence of input variables each of which this function computes
				the gradient w.r.t.
			grad_outputs (tuple or list of :class:`~chainer.Variable` or None):
				A sequence of variables that gives the initial value of each output
				gradient.
				If an element is set to ``None``, an array filled with 1 is used.
				If this argument itself is ``None``, it is treated as a sequence of
				``None``\\ s.
			grad_inputs (tuple or list of :class:`~chainer.Variable` or None):
				A sequence of variables that gives the initial value of each input
				gradient. The gradients computed by the backprop
				algorithm are accumulated to them (not in-place). If an element
				is set to ``None``, the gradient is not accumulated to this value.
				If this argument itself is ``None``, it is treated as a sequence of
				``None``\\ s.
			set_grad (bool): If it is ``True``, the :attr:`Variable.grad_var`
				attribute of each input variable is set to the corresponding
				computed gradient variable.
			retain_grad (bool): If it is ``True``, the gradients w.r.t. all the
				intermediate variables are stored in the :attr:`Variable.grad_var`
				attribute. In this case, the ``set_grad`` option is ignored.
			enable_double_backprop (bool): If it is ``True``, the computed
				gradients can be further backpropagated. Enabling it may increase
				the memory consumption (and possibly the computational time) to
				remember the intermediate gradient values for the second
				backpropagation.

		Returns:
			A list of gradient variables w.r.t. the inputs.
	**/
	static public function grad(outputs, inputs, grad_outputs = None, grad_inputs = None, set_grad = False, retain_grad = False, enable_double_backprop = False) : Dynamic;
	/**
		Get the debug mode.
		Returns:
			bool: Return ``True`` if Chainer is in debug mode.
	**/
	static public function is_dubug() : Dynamic;
	/**
		Make a context manager which disables back-propagation.

		In this context, Chainer does not make a computational graph. It has the
		benefit of reducing memory consumption. However, a
		:class:`~chainer.Variable` created in this context does not hold a
		reference to the :class:`~chainer.FunctionNode` that created itself so no
		gradients are accumulated by :func:`~chainer.Variable.backward`.

		In the following example, ``y`` is created in this context, which means
		that calling :func:`~chainer.Variable.backward` on ``y`` has no effect on
		the gradients of ``x``.

		>>> x = chainer.Variable(np.array([1,], 'f'))
		>>> with chainer.no_backprop_mode():
		...     y = x + 1
		>>> y.backward()
		>>> x.grad is None
		True

		.. seealso::

		   See :func:`force_backprop_mode` for details on how to override this
		   context.
	**/
	static public function no_backprop_mode() : Dynamic;	static public function report(values:Dynamic, ?observer:Dynamic) : Dynamic;
	/**
		Returns a report scope with the current reporter.
		This is equivalent to ``get_current_reporter().scope(observation)``,
		except that it does not make the reporter current redundantly.
	**/
	static public function report_scope(observation:Dynamic) : Dynamic;
	/**
		Set the debug mode.
		.. note::
			This method changes the global state. When you use this method on
			multi-threading environment, it may affect other threads.
		Args:
			debug (bool): New debug mode.
	**/
	static public function set_debug(debug:Dynamic) : Dynamic;
	/**
		Determines if we should use cuDNN.
		This function checks ``chainer.config.use_cudnn``,
		``chainer.cuda.cudnn_enabled``, and the cuDNN version. Note that
		``cudnn_enabled`` flag is fixed at loading of :mod:`chainer` module.
		Args:
			level (str): cuDNN use level. It must be either ``'==always'`` or
				``'>=auto'``. ``'==always'`` indicates that the ``use_cudnn``
				config must be ``'always'`` to use cuDNN.
			lowest_version (int): Required lowest cuDNN version. It must be
				non-negative.
		Returns:
			bool: ``True`` if the caller should use cuDNN.
	**/
	static public function should_use_cudnn(level:Dynamic, ?lowest_version:Dynamic) : Dynamic;
	/**
		using_config(name, value, config=chainer.config)

		Context manager to temporarily change the thread-local configuration.

		Args:
			name (str): Name of the configuration to change.
			value: Temporary value of the configuration entry.
			config (~chainer.configuration.LocalConfig): Configuration object.
	**/
	static public function using_config(name:Dynamic, value:Dynamic, ?config:Dynamic) : Dynamic;
}