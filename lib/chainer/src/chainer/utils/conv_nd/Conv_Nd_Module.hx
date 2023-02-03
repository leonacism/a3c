package chainer.utils.conv_nd;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.utils.conv_nd') extern class Conv_Nd_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function as_tuple(x:Dynamic, n:Dynamic) : Dynamic;
	static public function col2im_nd_cpu(col:Dynamic, stride:Dynamic, pad:Dynamic, dims:Dynamic) : Dynamic;
	static public function col2im_nd_gpu(col:Dynamic, stride:Dynamic, pad:Dynamic, dims:Dynamic) : Dynamic;
	/**
		Calculates output size of convolution.
		This function takes the size of input feature map, kernel, stride, and
		pooling of one particular dimension, then calculates the output feature
		map size of that dimension.
		.. seealso:: :func:`~chainer.utils.get_deconv_outsize`
		Args:
			size (int): The size of input feature map. It usually is the length of
				a side of feature map.
			k (int): The size of convolution kernel.
			s (int): The size of stride.
			p (int): The size of padding.
			cover_all (bool): Use ``cover_all`` option or not.
			d (int): The size of dilation.
		Returns:
			int: The expected output size of the convolution operation.
	**/
	static public function get_conv_outsize(size:Dynamic, k:Dynamic, s:Dynamic, p:Dynamic, ?cover_all:Dynamic, ?d:Dynamic) : Dynamic;
	/**
		Calculates output size of deconvolution.
		This function takes the size of input feature map, kernel, stride, and
		pooling of one particular dimension, then calculates the output feature
		map size of that dimension.
		.. seealso:: :func:`~chainer.utils.get_conv_outsize`
		Args:
			size (int): The size of input feature map. It usually is the length of
				a side of feature map.
			k (int): The size of deconvolution kernel.
			s (int): The size of stride.
			p (int): The size of padding.
			cover_all (bool): Use ``cover_all`` option or not.
			d (int): The size of dilation.
		Returns:
			int: The expected output size of the deconvolution operation.
	**/
	static public function get_deconv_outsize(size:Dynamic, k:Dynamic, s:Dynamic, p:Dynamic, ?cover_all:Dynamic, ?d:Dynamic) : Dynamic;
	static public function im2col_nd_cpu(img:Dynamic, ksize:Dynamic, stride:Dynamic, pad:Dynamic, ?pval:Dynamic, ?cover_all:Dynamic) : Dynamic;
	static public function im2col_nd_gpu(img:Dynamic, ksize:Dynamic, stride:Dynamic, pad:Dynamic, ?cover_all:Dynamic) : Dynamic;
}