package pixi.core.texture;
import js.lib.Uint32Array;
import pixi.core.geom.shape.Rectangle;

/**
 * ...
 * @author leonaci
 */
class TextureUvs
{
	public var uvsUint32(default, null):Uint32Array;
	
	private var x0:Float;
	private var y0:Float;
	private var x1:Float;
	private var y1:Float;
	private var x2:Float;
	private var y2:Float;
	private var x3:Float;
	private var y3:Float;

	public function new() {
		x0 = 0; y0 = 0;
		x1 = 1; y1 = 0;
		x2 = 1; y2 = 1;
		x3 = 0; y3 = 1;
		
		uvsUint32 = new Uint32Array(4);
	}
	
	public function set(frame:Rectangle, baseFrame:Rectangle, rotate:Bool) {
		var tw = baseFrame.width;
		var th = baseFrame.height;
		
		x0 = frame.x / tw;
		y0 = frame.y / th;
		
		x1 = (frame.x + frame.width) / tw;
		y1 = frame.y / th;
		
		x2 = (frame.x + frame.width) / tw;
		y2 = (frame.y + frame.height) / th;
		
		x3 = frame.x / tw;
		y3 = (frame.y + frame.height) / th;
		
		var X0:UInt = Std.int(x0 * 65535);
		var Y0:UInt = Std.int(y0 * 65535);
		
		var X1:UInt = Std.int(x1 * 65535);
		var Y1:UInt = Std.int(y1 * 65535);
		
		var X2:UInt = Std.int(x2 * 65535);
		var Y2:UInt = Std.int(y2 * 65535);
		
		var X3:UInt = Std.int(x3 * 65535);
		var Y3:UInt = Std.int(y3 * 65535);
		
        uvsUint32[0] = ((Y0 & 0xFFFF) << 16) | (X0 & 0xFFFF);
        uvsUint32[1] = ((Y1 & 0xFFFF) << 16) | (X1 & 0xFFFF);
        uvsUint32[2] = ((Y2 & 0xFFFF) << 16) | (X2 & 0xFFFF);
        uvsUint32[3] = ((Y3 & 0xFFFF) << 16) | (X3 & 0xFFFF); 
	}
}