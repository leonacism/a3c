package chainer.utils.type_check;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.utils.type_check') extern class Type_Check_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	static public function _eval_expr(v:Dynamic) : Dynamic;
	static public function _flip(f:Dynamic) : Dynamic;
	static public function _get_type(name:Dynamic, index:Dynamic, array:Dynamic, accept_none:Dynamic) : Dynamic;
	static public function _make_bin_operator(exp:Dynamic, priority:Dynamic, func:Dynamic, ?right_associative:Dynamic) : Dynamic;
	static public function _make_bool_operator(exp:Dynamic, inv:Dynamic, func:Dynamic) : Dynamic;
	static public function _make_un_operator(exp:Dynamic, priority:Dynamic, func:Dynamic) : Dynamic;
	static public var _prod : Dynamic;
	static public function _prod_impl(xs:Dynamic) : Dynamic;
	static public function _repr(v:Dynamic) : Dynamic;
	static public function _str_subscript(exp:Dynamic) : Dynamic;
	static public var _thread_local : Dynamic;
	static public function eval(exp:Dynamic) : Dynamic;
	/**
		Evaluates and tests all given expressions.
		This function evaluates given boolean expressions in order. When at least
		one expression is evaluated as ``False``, that means the given condition is
		not satisfied.
		You can check conditions with this function.
		Args:
			bool_exprs (tuple of Bool expressions): Bool expressions you want to
				evaluate.
	**/
	static public function expect(?bool_exprs:python.VarArgs<Dynamic>)
	static public function get_function_check_context(f:Dynamic) : Dynamic;
	static public function get_light_types(data:Dynamic) : Dynamic;
	static public function get_types(data:Dynamic, name:Dynamic, accept_none:Dynamic) : Dynamic;
	static public function in_light_mode() : Dynamic;
	static public var light_mode : Dynamic;
	static public function make_variable(value:Dynamic, name:Dynamic) : Dynamic;
	static public function prod(xs:Dynamic) : Dynamic;
	static public function same_types(?arrays:python.VarArgs<Dynamic>) : Dynamic;
}