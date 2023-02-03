package chainer.computational_graph;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.computational_graph', 'ComputationalGraph') extern class ComputationalGraph {
	/**
		Class that represents computational graph.

		.. note::

			We assume that the computational graph is directed and acyclic.

		Args:
			nodes (list): List of nodes. Each node is either
				 :class:`VariableNode` object or :class:`Function` object.
			edges (list): List of edges. Each edge consists of pair of nodes.
			variable_style (dict): Dot node style for variable.
			function_style (dict): Dot node style for function.
			rankdir (str): Direction of the graph that must be
				TB (top to bottom), BT (bottom to top), LR (left to right)
				or RL (right to left).
			remove_variable (bool): If ``True``, :class:`~chainer.Variable`\\ s are
				removed from the resulting computational graph. Only
				:class:`~chainer.Function`\\ s are shown in the output.
			show_name (bool): If ``True``, the ``name`` attribute of each node is
				added to the label of the node. Default is ``True``.

		.. note::

			The default behavior of :class:`~chainer.ComputationalGraph` has been
			changed from v1.23.0, so that it ouputs the richest representation of
			a graph as default, namely, styles are set and names of functions and
			variables are shown. To reproduce the same result as previous versions
			(<= v1.22.0), please specify `variable_style=None`,
			`function_style=None`, and `show_name=False` explicitly.

	**/

	static public function __class__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Implement delattr(self, name).
	**/
	public function __delattr__(name:Dynamic):Dynamic;
	static public var __dict__ : Dynamic;
	/**
		__dir__() -> list
		default dir() implementation
	**/
	public function __dir__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	static public var __doc__ : Dynamic;
	/**
		Return self==value.
	**/
	public function __eq__(value:Dynamic) : Dynamic;
	/**
		default object formatter
	**/
	public function __format__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return self>=value.
	**/
	public function __ge__(value:Dynamic):Dynamic;
	/**
		Return getattr(self, name).
	**/
	public function __getattribute__(name:Dynamic):Dynamic;
	/**
		Return self>value.
	**/
	public function __gt__(value:Dynamic):Dynamic;
	/**
		Return hash(self).
	**/
	public function __hash__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	@:native("__init__")
	public function ___init__(nodes:Dynamic, edges:Dynamic, ?variable_style:Dynamic, ?function_style:Dynamic, ?rankdir:Dynamic, ?remove_variable:Dynamic, ?show_name:Dynamic):Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new(nodes:Dynamic, edges:Dynamic, ?variable_style:Dynamic, ?function_style:Dynamic, ?rankdir:Dynamic, ?remove_variable:Dynamic, ?show_name:Dynamic):Void;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	/**
		Return self<value.
	**/
	public function __lt__(value:Dynamic):Dynamic;
	static public var __module__ : Dynamic;
	/**
		Return self!=value.
	**/
	public function __ne__(value:Dynamic):Dynamic;
	/**
		Create and return a new object.  See help(type) for accurate signature.
	**/
	static public function __new__(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		helper for pickle
	**/
	public function __reduce__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		helper for pickle
	**/
	public function __reduce_ex__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return repr(self).
	**/
	public function __repr__():Dynamic;
	/**
		Implement setattr(self, name, value).
	**/
	public function __setattr__(name:Dynamic, value:Dynamic):Dynamic;
	/**
		__sizeof__() -> int
		size of object in memory, in bytes
	**/
	public function __sizeof__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return str(self).
	**/
	public function __str__():Dynamic;
	/**
		Abstract classes can override this to customize issubclass().
		
		This is invoked early on by abc.ABCMeta.__subclasscheck__().
		It should return True, False or NotImplemented.  If it returns
		NotImplemented, the normal algorithm is used.  Otherwise, it
		overrides the normal algorithm (and the outcome is cached).
	**/
	static public function __subclasshook__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		list of weak references to the object (if defined)
	**/
	public var __weakref__ : Dynamic;
	/**
	    Converts graph in dot format.

        `label` property of is used as short description of each node.
        Returns:
            str: The graph in dot format.
	**/
	public function _to_dot() : Dynamic;
	/**
	    Dumps graph as a text.

        Args:
            format(str): The graph language name of the output.
            Currently, it must be 'dot'.

        Returns:
            str: The graph in specified format.
	**/
	public function dump(?format:Dynamic) : Dynamic;
}