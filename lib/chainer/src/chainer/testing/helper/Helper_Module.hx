package chainer.testing.helper;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.testing.helper') extern class Helper_Module {
	static public var __builtins__ : Dynamic;
	static public var __cached__ : Dynamic;
	static public var __doc__ : Dynamic;
	static public var __file__ : Dynamic;
	static public var __loader__ : Dynamic;
	static public var __name__ : Dynamic;
	static public var __package__ : Dynamic;
	static public var __spec__ : Dynamic;
	/**
		
	**/
	static public function assert_warns(expected:Dynamic) : Dynamic;
	/**
		Run a test case only when given requirements are satisfied.
		.. admonition:: Example
		   This test case runs only when `numpy>=1.10` is installed.
		   >>> from chainer import testing
		   ... class Test(unittest.TestCase):
		   ...     @testing.with_requires('numpy>=1.10')
		   ...     def test_for_numpy_1_10(self):
		   ...         pass
		Args:
			requirements: A list of string representing requirement condition to
				run a given test case.
	**/
	static public function with_requires(?requirements:python.VarArgs<Dynamic>) : Dynamic;
}