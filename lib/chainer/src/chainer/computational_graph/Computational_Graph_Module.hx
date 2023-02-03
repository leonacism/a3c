package chainer.computational_graph;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.computational_graph') extern class Computational_Graph_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public var _func_style : Dynamic;
	static public function _skip_variable(nodes:Dynamic, edges:Dynamic) : Dynamic;
	static public var _var_style : Dynamic;
	
	/**
		Builds a graph of functions and variables backward-reachable from outputs.

			Args:
				outputs(list): nodes from which the graph is constructed.
					Each element of outputs must be either :class:`~chainer.Variable`
					object, :class:`~chainer.variable.VariableNode` object, or
					:class:`~chainer.Function` object.
				remove_split(bool): It must be ``True``. This argument is left for
					backward compatibility.
				variable_style(dict): Dot node style for variable.
					Possible keys are 'shape', 'color', 'fillcolor', 'style', and etc.
				function_style(dict): Dot node style for function.
				rankdir (str): Direction of the graph that must be
					TB (top to bottom), BT (bottom to top), LR (left to right)
					or RL (right to left).
				remove_variable (bool): If ``True``, :class:`~chainer.Variable`\\ s are
					removed from the resulting computational graph. Only
					:class:`~chainer.Function`\\ s are shown in the output.
				show_name (bool): If ``True``, the ``name`` attribute of each node is
					added to the label of the node. Default is ``True``.

			Returns:
				ComputationalGraph: A graph consisting of nodes and edges that
				are backward-reachable from at least one of ``outputs``.

				If ``unchain_backward`` was called in some variable in the
				computational graph before this function, backward step is
				stopped at this variable.

				For example, suppose that computational graph is as follows::

						|--> f ---> y
					x --+
						|--> g ---> z

				Let ``outputs = [y, z]``.
				Then the full graph is emitted.

				Next, let ``outputs = [y]``. Note that ``z`` and ``g``
				are not backward-reachable from ``y``.
				The resulting graph would be following::

					x ---> f ---> y

				See :class:`TestGraphBuilder` for details.

			.. note::

				The default behavior of :class:`~chainer.ComputationalGraph` has been
				changed from v1.23.0, so that it ouputs the richest representation of
				a graph as default, namely, styles are set and names of functions and
				variables are shown. To reproduce the same result as previous versions
				(<= v1.22.0), please specify `variable_style=None`,
				`function_style=None`, and `show_name=False` explicitly.
	**/
	static public function build_computational_graph(outputs:Dynamic, ?remove_split:Dynamic, ?variable_style:Dynamic, ?function_style:Dynamic, ?rankdir:Dynamic, ?remove_variable:Dynamic, ?show_name:Dynamic) : Dynamic;
}