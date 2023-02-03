package chainer.testing.condition;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.testing.condition') extern class Condition_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		Decorator that imposes the test to be successful in a row.
		Decorated test case is launched multiple times.
		The case is regarded as passed only if it is successful
		specified times in a row.
		.. note::
			In current implementation, this decorator grasps the
			failure information of each trial.
		Args:
			times(int): The number of trials.
	**/
	static public function repeat(times:Dynamic) : Dynamic;
	/**
		Decorator for multiple trial of the test case.
		The decorated test case is launched multiple times.
		The case is judged as passed at least specified number of trials.
		If the number of successful trials exceeds `min_success`,
		the remaining trials are skipped.
		Args:
			times(int): The number of trials.
			min_success(int): Threshold that the decorated test
				case is regarded as passed.
	**/
	static public function repeat_with_success_at_least(times:Dynamic, min_success:Dynamic) : Dynamic;
	/**
		Decorator that imposes the test to be successful at least once.
		Decorated test case is launched multiple times.
		The case is regarded as passed if it is successful
		at least once.
		.. note::
			In current implementation, this decorator grasps the
			failure information of each trial.
		Args:
			times(int): The number of trials.
	**/
	static public function retry(times:Dynamic) : Dynamic;
}