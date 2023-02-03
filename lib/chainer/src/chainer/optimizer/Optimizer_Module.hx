package chainer.optimizer;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.optimizer') extern class Optimizer_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _sum_sqnorm(arr:Dynamic) : Dynamic;
	/**
		Time-dependent annealed Gaussian noise function from the paper:
		`Adding Gradient Noise Improves Learning for Very Deep Networks
		<https://arxiv.org/pdf/1511.06807>`_.
	**/
	static public function exponential_decay_noise(xp:Dynamic, shape:Dynamic, dtype:Dynamic, hook:Dynamic, opt:Dynamic) : Dynamic;
}