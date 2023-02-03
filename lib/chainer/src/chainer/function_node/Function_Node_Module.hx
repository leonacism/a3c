package chainer.function_node;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.function_node') extern class Function_Node_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _backprop(outputs, inputs, grad_required, retain_grad, grads) : Dynamic;
	static public function _get_ordered_func_heap() : Dynamic;
	/*
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
	static public function grad(outputs, inputs, grad_outputs=None, grad_inputs=None, set_grad=False, retain_grad=False, enable_double_backprop=False) : Dynamic;
}