package chainer.iterators.multiprocess_iterator;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.iterators.multiprocess_iterator') extern class Multiprocess_Iterator_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _fetch_dataset : Dynamic;
	static public var _fetch_mem_bulk : Dynamic;
	static public var _fetch_mem_size : Dynamic;
	static public function _fetch_run(inputs:Dynamic) : Dynamic;
	static public function _fetch_setup(dataset:Dynamic, mem_size:Dynamic, mem_bulk:Dynamic) : Dynamic;
	static public function _measure(data:Dynamic) : Dynamic;
	static public function _pack(data:Dynamic, mem:Dynamic, offset:Dynamic, limit:Dynamic) : Dynamic;
	static public var _PrefetchState : Dynamic;
	static public function _report_pid(_:Dynamic) : Dynamic; 
	static public var _response_time : Dynamic;
	static public var _short_time : Dynamic;
	static public function _unpack(data:Dynamic, mem:Dynamic) : Dynamic;
}