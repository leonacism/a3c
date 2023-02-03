package util;
import haxe.macro.Expr;

/**
 * ...
 * @author leo
 */
class Graphics {
	public var WIDTH(default, null):Float;
	public var HEIGHT(default, null):Float;

	public function background(r:Int, g:Int, b:Int) throw 'Not Implemented.';

	public function color(r:Int, g:Int, b:Int) throw 'Not Implemented.';
	
	public function point(x:Float, y:Float, size:Int) throw 'Not Implemented.';
	
	public function line(x1:Float, y1:Float, x2:Float, y2:Float) throw 'Not Implemented.';
	
	public function arc(x:Float, y:Float, r:Float) throw 'Not Implemented.';
	
	public function text(str:String, x:Float, y:Float, size:Int) throw 'Not Implemented.';
	
	public function setSize(size:Float) throw 'Not Implemented.';
}
