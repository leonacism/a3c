package pixi.util;
import haxe.Timer;

/**
 * FPS調整機能付きの基本ループ構造
 * @author leonaci
 */
class Current {
	public var FPS(default, null):Float;
	
	public var frame(default, null):Int;
	public var currentTime(default, null):Float;
	public var actualFPS(default, null):Float;
	public var duration(default, null):Float;
	
	private var handler:Void->Void;
	
	public function new(?FPS:Float=60) {
		this.FPS = FPS;
		frame = 0;
		currentTime = 0.0;
		actualFPS = 0.0;
		duration = 0.0;
	}
	
	public function addFrameHandler(handler:Void->Void):Void {
		this.handler = handler;
	}
	
	public function run() {
		var loop = null;
		
		var durationList:Array<Float> = [], prevTime = Timer.stamp(), sleep = 0.0, sumtime = 0.0;
		(loop = function() {
			
			handler();
			
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