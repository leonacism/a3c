package chainer.backends.cuda;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.backends.cuda') extern class Cuda_Module {
	static public var DummyDevice : Dynamic;
	static public var _SHOULD_USE_CUDNN : Dynamic;
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __path__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _array_to_cpu(array:Dynamic, stream:Dynamic) : Dynamic;
	static public function _array_to_gpu(array:Dynamic, device:Dynamic, stream:Dynamic) : Dynamic;
	static public var _cudnn_version : Dynamic;
	static public function _get_device(?args:python.VarArgs<Dynamic>) : Dynamic;
	static public var _integer_types : Dynamic;
	static public var _max_workspace_size : Dynamic;
	static public var _resolution_error : Dynamic;
	static public var available : Dynamic;
	/**
		Checks if CUDA is available.
		When CUDA is correctly set up, nothing happens.
		Otherwise it raises ``RuntimeError``.
	**/
	static public function check_cuda_available() : Dynamic;
	/**
		Clears the memoized results for all functions decorated by memoize.
		This function works like :func:`cupy.clear_memo` as a counterpart for
		:func:`chainer.cuda.memoize`. It can be used even if CUDA is not available.
		In such a case, this function does nothing.
	**/
	static public function clear_memo() : Dynamic;
	/**
		Copies a :class:`cupy.ndarray` object using the default stream.
		This function can copy the device array to the destination array on another
		device.
		Args:
			array (cupy.ndarray): Array to be copied.
			out (cupy.ndarray): Destination array.
				If it is not ``None``, then ``out_device`` argument is ignored.
			out_device: Destination device specifier. Actual device object is
				obtained by passing this value to :func:`get_device`.
			stream (cupy.cuda.Stream): CUDA stream.
		Returns:
			cupy.ndarray: Copied array.
			If ``out`` is not specified, then the array is allocated on the device
			specified by ``out_device`` argument.
	**/
	static public function copy(array:Dynamic, ?out:Dynamic, ?out_device:Dynamic, ?stream:Dynamic) : Dynamic;
	static public var cudnn_enabled : Dynamic;
	/**
		Creates an elementwise kernel function.
		This function uses :func:`~chainer.cuda.memoize` to cache the
		kernel object, i.e. the resulting kernel object is cached for each argument
		combination and CUDA device.
		The arguments are the same as those for
		:class:`cupy.ElementwiseKernel`, except that the ``name`` argument is
		mandatory.
	**/
	static public function elementwise(in_params:Dynamic, out_params:Dynamic, operation:Dynamic, name:Dynamic, ?kwargs:python.KwArgs<Dynamic>) : Dynamic;
	/*
		Gets an appropriate one from :mod:`numpy` or :mod:`cupy`.
		This is almost equivalent to :func:`cupy.get_array_module`. The differences
		are that this function can be used even if CUDA is not available and that
		it will return their data arrays' array module for
		:class:`~chainer.Variable` arguments.
		Args:
			args: Values to determine whether NumPy or CuPy should be used.
		Returns:
			module: :mod:`cupy` or :mod:`numpy` is returned based on the types of
			the arguments.
	**/
	static public function get_array_module(?args:python.VarArgs<Dynamic>) : Dynamic;
	/**
		Gets the device from a device object, an ID integer or an array object.
		.. note::
			This API is deprecated. Please use
			:func:`~chainer.cuda.get_device_from_id`
			or :func:`~chainer.cuda.get_device_from_array` instead.
		This is a convenient utility to select a correct device if the type of
		``arg`` is unknown (i.e., one can use this function on arrays that may be
		on CPU or GPU). The returned device object supports the context management
		protocol of Python for the *with* statement.
		Args:
			args: Values to specify a GPU device. The first device object, integer
				or :class:`cupy.ndarray` object is used to select a device.
				If it is a device object, it is returned. If it is an integer,
				the corresponding device is returned. If it is a CuPy array,
				the device on which this array reside is returned. If any
				arguments are neither integers nor CuPy arrays, a dummy device
				object representing CPU is returned.
		Returns:
			Device object specified by given ``args``.
		.. seealso::
		   See :class:`cupy.cuda.Device` for the device selection not by arrays.
	**/
	static public function get_device(?args:python.VarArgs<Dynamic>) : Dynamic;
	/**
		Gets the device from a list of CuPy array or a single CuPy array.
		The device on which the given CuPy array reside is returned.
		Args:
			array (cupy.ndarray or list of cupy.ndarray):
				A CuPy array which this function returns the device corresponding
				to. If a list of :class:`cupy.ndarray`\\ s are given, it returns
				the first device object of an array in the list.
	**/
	static public function get_device_from_array(?arrays:python.VarArgs<Dynamic>) : Dynamic;
	/**
		Gets the device from an ID integer.
		Args:
			device_id (int or None): The ID of the device which this function
				returns.
	**/
	static public function get_device_from_id(device_id:Dynamic) : Dynamic;
	/**
		Gets the workspace size for cuDNN.
		Check "cuDNN Library User Guide" for detail.
		Returns:
			int: The workspace size for cuDNN.
	**/
	static public function get_max_workspace_size() : Dynamic;
	/**
		Makes a function memoizing the result for each argument and device.
		This is a similar version of :func:`cupy.memoize`. The difference is that
		this function can be used in the global scope even if CUDA is not
		available. In such case, this function does nothing.
		.. note::
		   This decorator acts as a dummy if CUDA is not available. It cannot be
		   used for general purpose memoization even if ``for_each_device`` is set
		   to False.
	**/
	static public function memoize(?for_each_device:Dynamic) : Dynamic;
	/**
		Creates a global reduction kernel function.
		This function uses :func:`~chainer.cuda.memoize` to cache the resulting
		kernel object, i.e. the resulting kernel object is cached for each argument
		combination and CUDA device.
		The arguments are the same as those for
		:class:`cupy.ReductionKernel`, except that the ``name`` argument is
		mandatory.
	**/
	static public function reduce(in_params:Dynamic, out_params:Dynamic, map_expr:Dynamic, reduce_expr:Dynamic, post_map_expr:Dynamic, identity:Dynamic, name:Dynamic, ?kwargs:python.KwArgs<Dynamic>) : Dynamic;
	/**
		Sets the workspace size for cuDNN.
		Check "cuDNN Library User Guide" for detail.
		Args:
			size: The workspace size for cuDNN.
	**/
	static public function set_max_workspace_size(size:Dynamic) : Dynamic;
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
		Copies the given GPU array to host CPU.
		Args:
			array (numpy.ndarray, cupy.ndarray, None, list or tuple):
				Array or arrays to be sent to CPU.
			stream (cupy.cuda.Stream): CUDA stream.
		Returns:
			numpy.ndarray, list or tuple: Array on CPU.
			If some of the arrays are already on CPU, then this function just
			returns those arrays without performing any copy.
			If input arrays include `None`, it is returned as `None` as is.
	**/
	static public function to_cpu(array:Dynamic, ?stream:Dynamic) : Dynamic;
	/**
		Copies the given CPU array to the specified device.
		Args:
			array (numpy.ndarray, cupy.ndarray, None, list or tuple):
				Array or arrays to be sent to GPU.
			device: Device specifier.
			stream (~cupy.cuda.Stream): *(deprecated since v3.0.0)*
				CUDA stream. If not ``None``, the copy runs asynchronously.
		Returns:
			cupy.ndarray, list or tuple: Array or arrays on GPU.
			If some of the arrays are already on GPU, then this function just
			returns those arrays without performing any copy.
			If input arrays include `None`, it is returned as `None` as is.
	**/
	static public function to_gpu(array:Dynamic, ?device:Dynamic, ?stream:Dynamic) : Dynamic;
}