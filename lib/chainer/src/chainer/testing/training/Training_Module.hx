package chainer.testing.training;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.testing.training') extern class Training_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _error : Dynamic;
	static public function check_available() : Dynamic;
	static public function get_error() : Dynamic;
	/**
		Returns a :class:`~chainer.training.Trainer` object with mock updater.
		The returned trainer can be used for testing the trainer itself and the
		extensions. A mock object is used as its updater. The update function set
		to the mock correctly increments the iteration counts (
		``updater.iteration``), and thus you can write a test relying on it.
		Args:
			stop_trigger: Stop trigger of the trainer.
			iter_per_epoch: The number of iterations per epoch.
		Returns:
			Trainer object with a mock updater.
	**/
	static public function get_trainer_with_mock_updater(?stop_trigger:Dynamic, ?iter_per_epoch:Dynamic) : Dynamic;
	static public function is_available() : Dynamic;
}