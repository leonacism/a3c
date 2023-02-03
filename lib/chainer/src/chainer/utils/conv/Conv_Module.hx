package chainer.utils.conv;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.utils.conv') extern class Conv_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function col2im_cpu(col:Dynamic, sy:Dynamic, sx:Dynamic, ph:Dynamic, pw:Dynamic, h:Dynamic, w:Dynamic, ?dy:Dynamic, ?dx:Dynamic) : Dynamic;
	static public function col2im_gpu(col:Dynamic, sy:Dynamic, sx:Dynamic, ph:Dynamic, pw:Dynamic, h:Dynamic, w:Dynamic, ?dy:Dynamic, ?dx:Dynamic) : Dynamic;
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
	static public function im2col_cpu(img:Dynamic, kh:Dynamic, kw:Dynamic, sy:Dynamic, sx:Dynamic, ph:Dynamic, pw:Dynamic, ?pval:Dynamic, ?cover_all:Dynamic, ?dy:Dynamic, ?dx:Dynamic, ?out_h:Dynamic, ?out_w:Dynamic) : Dynamic;
	static public function im2col_gpu(img:Dynamic, kh:Dynamic, kw:Dynamic, sy:Dynamic, sx:Dynamic, ph:Dynamic, pw:Dynamic, ?cover_all:Dynamic, ?dy:Dynamic, ?dx:Dynamic, ?out_h:Dynamic, ?out_w:Dynamic) : Dynamic;
}