package pixi.core.renderer;
import haxe.ds.Vector;
import js.lib.Uint8Array;
import js.html.webgl.Extension;
import js.html.webgl.GL;
import js.html.webgl.extension.OESVertexArrayObject;
import pixi.gl.GLAttributeState;
import pixi.util.BlendMode;

/**
 * ...
 * @author leonaci
 */
class WebGLState
{
	@:extern static inline private var BLEND = 0;
	@:extern static inline private var DEPTH_TEST = 1;
	@:extern static inline private var FRONT_FACE = 2;
	@:extern static inline private var CULL_FACE = 3;
	@:extern static inline private var BLEND_FUNC = 4;
	
	private var gl:GL;
	
	private var maxAttribs:Int;
	private var attribState(default, null):GLAttributeState;
	
	private var activeState:Uint8Array;
	private var defaultState:Uint8Array;
	
	private var stack:Array<Uint8Array>;
	private var stackIndex:Int;
	
	private var nativeVAOExtension:OESVertexArrayObject;
	
	public function new(gl:GL) {
		this.gl = gl;
		
		maxAttribs = gl.getParameter(GL.MAX_VERTEX_ATTRIBS);
		attribState = {
			tempAttribState: Vector.fromArrayCopy([for(i in 0...maxAttribs) false]),
			attribState: Vector.fromArrayCopy([for(i in 0...maxAttribs) false]),
		};
		
		activeState = new Uint8Array(16);
		defaultState = new Uint8Array(16);
		defaultState[BLEND] = 1;
		
		stack = [];
		stackIndex = 0;
		
		for (name in ['OES_vertex_array_object', 'MOZ_OES_vertex_array_object', 'WEBKIT_OES_vertex_array_object']) {
			var ext = gl.getExtension(name);
			if (ext != null) nativeVAOExtension = ext;
		}
	}
	
	public function push():Void {
		if (stack[stackIndex] == null) stack[stackIndex] = new Uint8Array(16);
		var state = stack[stackIndex];
		
		stackIndex++;
		
		for (i in 0...16) state[i] = activeState[i];
	}
	
	public function pop():Void {
		stackIndex--;
		
		var state = stack[stackIndex];
		setState(state);
	}
	
	private inline function setState(state:Uint8Array):Void {
		setBlend(state[BLEND]==1? true : false);
		setBlendMode(cast state[BLEND_FUNC]);
		setDepthTest(state[DEPTH_TEST]==1? true : false);
		setCullFace(state[CULL_FACE]==1? true : false);
		setFrontFace(state[FRONT_FACE]==1? true : false);
	}
	
	public inline function setBlend(value:Bool):Void {
		var f:Int = value? 1 : 0;
		if (activeState[BLEND] == f) return;
		activeState[BLEND] = f;
		value? gl.enable(GL.BLEND) : gl.disable(GL.BLEND);
	}
	
	public inline function setBlendMode(blendMode:BlendMode):Void {
		if (activeState[BLEND_FUNC] == blendMode) return;
		
		activeState[BLEND_FUNC] = blendMode;
		
		var mode = getGLBlendModes(blendMode);
		
		switch(mode.length) {
			case 2: gl.blendFunc(mode[0], mode[1]);
			case 4: gl.blendFuncSeparate(mode[0], mode[1], mode[2], mode[3]);
			default: throw '!?';
		}
	}
	
	public inline function setDepthTest(value:Bool):Void {
		var f:Int = value? 1 : 0;
		if (activeState[DEPTH_TEST] == f) return;
		activeState[DEPTH_TEST] = f;
		value? gl.enable(GL.DEPTH_TEST) : gl.disable(GL.DEPTH_TEST);
	}
	
	public inline function setCullFace(value:Bool):Void {
		var f:Int = value? 1 : 0;
		if (activeState[CULL_FACE] == f) return;
		activeState[CULL_FACE] = f;
		value? gl.enable(GL.CULL_FACE) : gl.disable(GL.CULL_FACE);
	}
	
	public inline function setFrontFace(value:Bool):Void {
		var f:Int = value? 1 : 0;
		if (activeState[FRONT_FACE] == f) return;
		activeState[FRONT_FACE] = f;
		gl.frontFace(value? GL.CW : GL.CCW);
	}
	
	public inline function resetAttributes():Void {
		for (i in 0...maxAttribs) {
			attribState.tempAttribState[i] = false;
			attribState.attribState[i] = false;
		}
		for (i in 1...maxAttribs) gl.disableVertexAttribArray(i);
	}
	
	public inline function resetToDefault():Void {
		if (nativeVAOExtension != null) nativeVAOExtension.bindVertexArrayOES(null);
		
		resetAttributes();
		
		for(i in 0...16) activeState[i] = 32;
		
		gl.pixelStorei(GL.UNPACK_FLIP_Y_WEBGL, 0);
		
		setState(defaultState);
	}
	
	static private inline function getGLBlendModes(blendMode:BlendMode):Array<Int> {
		return switch(blendMode) {
			case BlendMode.Normal:      [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Add:         [GL.ONE, GL.DST_ALPHA];
			case BlendMode.Multiply:    [GL.DST_COLOR, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Screen:      [GL.ONE, GL.ONE_MINUS_SRC_COLOR];
			case BlendMode.Overlay:     [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Darken:      [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Lighten:     [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.ColorDodge:  [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.ColorBurn:   [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.HardLight:   [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.SoftLight:   [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Difference:  [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Exclusion:   [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Hue:         [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Saturation:  [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Color:       [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.Luminosity:  [GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			// not-premultiplied blend modes
			case BlendMode.NormalNpm:   [GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA, GL.ONE, GL.ONE_MINUS_SRC_ALPHA];
			case BlendMode.AddNpm:      [GL.SRC_ALPHA, GL.DST_ALPHA, GL.ONE, GL.DST_ALPHA];
			case BlendMode.ScreenNpm:   [GL.SRC_ALPHA, GL.ONE_MINUS_SRC_COLOR, GL.ONE, GL.ONE_MINUS_SRC_COLOR];
		}
	}
}