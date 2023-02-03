package pixi.core.sprites;
import js.lib.ArrayBuffer;
import js.lib.Float32Array;
import js.lib.Uint32Array;

/**
 * ...
 * @author leonaci
 */
class Buffer
{
	public var vertices:ArrayBuffer;
	public var float32View:Float32Array;
	public var uint32View:Uint32Array;
	
	public function new(size:Int) {
		vertices = new ArrayBuffer(size);
		float32View = new Float32Array(vertices);
		uint32View = new Uint32Array(vertices);
	}
	
	public function dispose():Void {
		vertices = null;
		float32View = null;
		uint32View = null;
	}
}