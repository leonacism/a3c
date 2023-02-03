package util;
import haxe.Timer;

/**
 * animation loop
 * @author leo
 */
class MainLoop {
	static var ml = new MainLoop();
	static var instance(get, never):MainLoop;
	static function get_instance() return ml;
	
	public static var init:Void->Void;
	public static var input:Void->Void;
	public static var update:Void->Void;
	public static var render:Void->Void;
	
	public static var frame(default, null):Int;
	public static var currentTime(default, null):Float;
	public static var FPS(default, null):Float;
	public static var actualFPS(default, null):Float;
	public static var duration(default, null):Float;
	
	function new() {}
	
	public static function start() {
		if(init==null || input==null || update==null || render==null) throw '`init` or `input` or `update` or `render` are not implemented.';
		
		frame = 0;
		currentTime = 0.0;
		FPS = 60.0;
		actualFPS = 0.0;
		duration = 0.0;
		
		instance.run();
	}
	
	private inline function run() {
		var loop = null;
		
		init();
		var durationList:Array<Float> = [], prevTime = Timer.stamp(), sleep = 0.0, sumtime = 0.0;
		(loop = function() {
			
			input();
			update();
			render();
			
			var tmp = Timer.stamp();
			duration = tmp - prevTime;
			prevTime = tmp;
			currentTime += duration;
			frame++;
			
			durationList.unshift(duration);
			sumtime += duration - (durationList.length>FPS? durationList.pop() : 0);
			actualFPS = frame%20==0? durationList.length / sumtime : actualFPS;
			sleep += 1.0/FPS - duration;
			
			Timer.delay(loop, cast sleep>0? 1000 * sleep:sleep = 0);
		})();
	}
}