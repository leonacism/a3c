package chainer.reporter;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.reporter') extern class Reporter_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _copy_variable() : Dynamic;
	static public function _get_device(x:Dynamic) : Dynamic;
	static public var _reporters : Dynamic;
	/**
		Returns the current reporter object.
	**/
	static public function get_current_reporter() : Dynamic;
	/**
		Reports observed values with the current reporter object.
		Any reporter object can be set current by the ``with`` statement. This
		function calls the :meth:`Report.report` method of the current reporter.
		If no reporter object is current, this function does nothing.
		.. admonition:: Example
		   The most typical example is a use within links and chains. Suppose that
		   a link is registered to the current reporter as an observer (for
		   example, the target link of the optimizer is automatically registered to
		   the reporter of the :class:`~chainer.training.Trainer`). We can report
		   some values from the link as follows::
			  class MyRegressor(chainer.Chain):
				  def __init__(self, predictor):
					  super(MyRegressor, self).__init__(predictor=predictor)
				  def __call__(self, x, y):
					  # This chain just computes the mean absolute and squared
					  # errors between the prediction and y.
					  pred = self.predictor(x)
					  abs_error = F.sum(F.abs(pred - y)) / len(x.data)
					  loss = F.mean_squared_error(pred, y)
					  # Report the mean absolute and squared errors.
					  report({'abs_error': abs_error, 'squared_error': loss}, self)
					  return loss
		   If the link is named ``'main'`` in the hierarchy (which is the default
		   name of the target link in the
		   :class:`~chainer.training.StandardUpdater`), these reported values are
		   named ``'main/abs_error'`` and ``'main/squared_error'``. If these values
		   are reported inside the :class:`~chainer.training.extension.Evaluator`
		   extension, ``'validation/'`` is added at the head of the link name, thus
		   the item names are changed to ``'validation/main/abs_error'`` and
		   ``'validation/main/squared_error'`` (``'validation'`` is the default
		   name of the Evaluator extension).
		Args:
			values (dict): Dictionary of observed values.
			observer: Observer object. Its object ID is used to retrieve the
				observer name, which is used as the prefix of the registration name
				of the observed value.
	**/
	static public function report(values:Dynamic, ?observer:Dynamic) : Dynamic;
	/**
		Returns a report scope with the current reporter.
		This is equivalent to ``get_current_reporter().scope(observation)``,
		except that it does not make the reporter current redundantly.
	**/
	static public function report_scope(observation:Dynamic) : Dynamic;
}