package a3c.ai.common;

/**
 * ...
 * @author leonaci
 */
class MathUtil {
	static public inline function softmax(xs:Array<Float>):Array<Float> {
		var as = [for(x in xs) Math.exp(x)];
		var sum = sumarray(as);
		return [for(a in as) a/sum];
	}
	
	static public inline function arraymax(xs:Array<Float>):Float {
		var max = Math.NEGATIVE_INFINITY;
		for(x in xs) max= (x>max? x : max);
		return max;
	}
	
	static public inline function argmax(xs:Array<Float>):Array<Int> {
		var max = Math.NEGATIVE_INFINITY;
		for(x in xs) max= (x>max? x : max);
		
		var c = [];
		for(x in xs) max==x? c.push(xs.indexOf(x)) :{};
		return c;
	}
	
	static public inline function sumarray(xs:Array<Float>):Float {
		var sum = 0.0;
		for(x in xs) sum+=x;
		return sum;
	}
	
	static public inline function random():Float return Math.random();
	
	static public inline function randomInt(x:Int):Int return Std.random(x); 
	
	static public inline function abs(x:Float):Float return Math.abs(x);
	
	static public inline function exp(x:Float):Float return Math.exp(x);
	
	static public inline function min(a:Float, b:Float):Float return Math.min(a, b);
	
	static public inline function sqrt(v:Float):Float return Math.sqrt(v);
}