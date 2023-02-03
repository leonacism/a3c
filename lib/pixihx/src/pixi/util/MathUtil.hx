package pixi.util;

/**
 * ...
 * @author leonaci
 */
class MathUtil {
	static public var PI(get, never):Float;
	static inline function get_PI():Float return 3.14159265358979;
	
	static public var POSITIVE_INFINITY(get, never):Float;
	static inline function get_POSITIVE_INFINITY():Float return Math.POSITIVE_INFINITY;
	
	static public var NEGATIVE_INFINITY(get, never):Float;
	static inline function get_NEGATIVE_INFINITY():Float return Math.NEGATIVE_INFINITY;
	
	static public var NaN(get, never):Float;
	static inline function get_NaN():Float return Math.NaN;
	
	static public inline function isNaN(f:Float):Bool return Math.isNaN(f);
	
	static public inline function abs(v:Float):Float return Math.abs(v);
	
	static public inline function max(a:Float, b:Float):Float return Math.max(a, b);
	
	static public inline function min(a:Float, b:Float):Float return Math.min(a, b);
	
	static public inline function sin(v:Float):Float return Math.sin(v);
	
	static public inline function cos(v:Float):Float return Math.cos(v);
	
	static public inline function tan(v:Float):Float return Math.tan(v);
	
	static public inline function asin(v:Float):Float return Math.asin(v);
	
	static public inline function acos(v:Float):Float return Math.acos(v);
	
	static public inline function atan(v:Float):Float return Math.atan(v);
	
	static public inline function atan2(y:Float, x:Float):Float return Math.atan2(y, x);
	
	static public inline function exp(v:Float):Float return Math.exp(v);
	
	static public inline function log(v:Float):Float return Math.log(v);
	
	static public inline function log2(v:Float):Int {
		var i:Int = cast v;
		var r = 0;
		var shift = 0;
		r =     (i > 0xFFFF? 1:0) << 4; i >>>= r;
		shift = (i > 0xFF  ? 1:0) << 3; i >>>= shift; r |= shift;
		shift = (i > 0xF   ? 1:0) << 2; i >>>= shift; r |= shift;
		shift = (i > 0x3   ? 1:0) << 1; i >>>= shift; r |= shift;
		return r | (i >> 1);
	}
	
	static public inline function pow(v:Float, exp:Float):Float return Math.pow(v, exp);
	
	static public inline function sqrt(v:Float):Float return Math.sqrt(v);
	
	static public inline function round(v:Float):Int return Math.round(v);
	
	static public inline function floor(v:Float):Int return Math.floor(v);
	
	static public inline function ceil(v:Float):Int return Math.ceil(v);
	
	static public inline function clamp(v:Float, min:Float, max:Float):Float return Math.min(Math.max(v, min),max);
	
	static public inline function randomFloat():Float return Math.random();
	
	static public inline function randomInt(x:Int):Int return Std.random(x);
	
	static public inline function int(x:Float):Int return Std.int(x);
	
	static public inline function sign(v:Float):Float return v!=0? v / abs(v) : 0;
	
	static public inline function isPowOf2(v:Int) return (v & (v - 1)) == 0 && v != 0;
	
	static public inline function nextPow2(v:Float):Int {
		var i = cast v + (v == 0? 1 : 0);
		--i;
		i |= i >>> 1;
		i |= i >>> 2;
		i |= i >>> 4;
		i |= i >>> 8;
		i |= i >>> 16;
		return i + 1;
	}
	
}