package pixi.util;

/**
 * ...
 * @author leonaci
 */
abstract Color(UInt) to UInt {
	public var r(get, set):Float;
	inline function get_r():Float return (this >> 16 & 0xFF) / 255;
	inline function set_r(r:Float):Float return {
		R = Std.int(MathUtil.clamp(r, 0, 1) * 255);
		return r;
	}
	
	public var g(get, set):Float;
	inline function get_g():Float return (this >>  8 & 0xFF) / 255;
	inline function set_g(g:Float):Float return {
		G = Std.int(MathUtil.clamp(g, 0, 1) * 255);
		return g;
	}
	
	public var b(get, set):Float;
	inline function get_b():Float return (this       & 0xFF) / 255;
	inline function set_b(b:Float):Float return {
		B = Std.int(MathUtil.clamp(b, 0, 1) * 255);
		return b;
	}
	
	public var a(get, set):Float;
	inline function get_a():Float return (this >> 24 & 0xFF) / 255;
	inline function set_a(a:Float):Float return {
		A = Std.int(MathUtil.clamp(a, 0, 1) * 255);
		return a;
	}
	
	public var R(get, set):Int;
	inline function get_R():Int return this >> 16 & 0xFF;
	inline function set_R(R:Int):Int return {
		this = (R << 16) | (this & 0xFF00FFFF);
		return R;
	}
	
	public var G(get, set):Int;
	inline function get_G():Int return this >>  8 & 0xFF;
	inline function set_G(G:Int):Int return {
		this = (G <<  8) | (this & 0xFFFF00FF);
		return G;
	}
	
	public var B(get, set):Int;
	inline function get_B():Int return this       & 0xFF;
	inline function set_B(B:Int):Int return {
		this = (B      ) | (this & 0xFFFFFF00);
		return B;
	}
	
	public var A(get, set):Int;
	inline function get_A():Int return this >> 24 & 0xFF;
	inline function set_A(A:Int):Int return {
		this = (A << 24) | hex;
		return A;
	}
	
	public var hex(get, set):Int;
	inline function get_hex():Int return this & 0xFFFFFF;
	inline function set_hex(hex:Int):Int {
		this = hex | (A << 24);
		return hex;
	}
	
	public var code(get, set):String;
	inline function get_code():String {
		return '#'+StringTools.hex(this & 0xFFFFFF, 6).toLowerCase();
	}
	inline function set_code(code:String):String {
		this = (A << 24) + Std.parseInt('0x' + code.substring(1, 7));
		return code;
	}
	
	public var rgba(get, set):{r:Float, g:Float, b:Float, a:Float}
	inline function get_rgba():{r:Float, g:Float, b:Float, a:Float} {
		return {
			r: (this>>16 & 0xFF) / 255,
			g: (this>> 8 & 0xFF) / 255,
			b: (this     & 0xFF) / 255,
			a: (this>>24 & 0xFF) / 255,
		};
	}
	inline function set_rgba(rgba:{r:Float, g:Float, b:Float, a:Float}):{r:Float, g:Float, b:Float, a:Float} {
		r = rgba.r;
		g = rgba.g;
		b = rgba.b;
		a = rgba.a;
		
		return rgba;
	}
	
	inline function new(data:UInt):Color this = data;
	
	static inline public function Rgba(r:Float, g:Float, b:Float, a:Float):Color {
		var A:UInt = Std.int(MathUtil.clamp(a, 0, 1) * 255);
		var R:UInt = Std.int(MathUtil.clamp(r, 0, 1) * 255);
		var G:UInt = Std.int(MathUtil.clamp(g, 0, 1) * 255);
		var B:UInt = Std.int(MathUtil.clamp(b, 0, 1) * 255);
		
		return new Color((A << 24) + (R << 16) + (G <<  8) + B);
	}
	
	static inline public function Hex(hex:Int, a:Float):Color {
		var A:UInt = Std.int(MathUtil.clamp(a, 0, 1) * 255);
		
		return new Color((A << 24) + hex);
	}
	
	static inline public function Code(code:String, a:Float):Color {
		var A:UInt = Std.int(MathUtil.clamp(a, 0, 1) * 255);
		
		return new Color(
			(A << 24) + Std.parseInt('0x' + code.substring(1, 3)) << 16
					  + Std.parseInt('0x' + code.substring(3, 5)) <<  8
					  + Std.parseInt('0x' + code.substring(5, 7))
		);
	}
	
	static inline public function Raw(data:UInt):Color return new Color(data);
	
}