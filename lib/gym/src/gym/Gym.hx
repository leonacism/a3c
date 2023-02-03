package gym;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('gym')
@:native('gym')
extern class Gym {
	static public function make(id:ID):Env;
	
	static public function spec(id:ID):Dynamic;
}