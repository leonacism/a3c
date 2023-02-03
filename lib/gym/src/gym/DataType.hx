package gym;

/**
 * ...
 * @author leonaci
 */
@:enum
abstract DataType(String) to String {
	var Integer = 'int';
	var Boolean = 'bool';
	var Float16 = 'float16';
	var Float32 = 'float32';
	var Float64 = 'float64';
}