package pixi;
import js.Browser;
import pixi.gl.GLConstants.Precision;
import pixi.gl.GLConstants.WrapKind;
import pixi.util.Constant.ScaleMode;

/**
 * ...
 * @author leonaci
 */
class Config {
	static public var RESOLUTION:Float = 1;
	static public var SCALE_MODE:ScaleMode = ScaleMode.Linear;
	static public var WRAP_MODE:WrapKind = WrapKind.ClampToEdge;
	static public var MIPMAP_TEXTURES:Bool = true;
	static public var GC_MAX_CHECK_COUNT:Int = 60 * 10;
	static public var GC_MAX_IDLE:Int = 60 * 60;
	static public var PRECISION_VERTEX:Precision = Precision.High;
	static public var PRECISION_FRAGMENT:Precision = Precision.Medium;
	static public var SPRITE_BATCH_SIZE:Int = 4096;
	static public var CAN_UPLOAD_SAME_BUFFER:Bool = !~/(iPad|iPhone|iPod)/.match(Browser.navigator.platform);
}