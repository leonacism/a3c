package chainer.configuration;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.configuration') extern class Configuration_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _print_attrs(obj:Dynamic, keys:Dynamic, file:Dynamic) : Dynamic;
	static public var config : Dynamic;
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
	static public var print_function : Dynamic;
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