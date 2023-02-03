package a3c.ai.actor;
import haxe.Timer;
import q.Q;

/**
 * ...
 * @author leonaci
 */
class Current {
	static public inline function start(process:Cont<Dynamic>, FPS:Float) {
		var duration = 0.0, frame=0, actualFPS=0.0, currentTime = 0.0, durationList:Array<Float> = [], prevTime = Timer.stamp(), sleep = 0.0, sumtime = 0.0;
		return Q.fork(Q.build({
			return process;
			
			var tmp = Timer.stamp();
			duration = tmp - prevTime;
			prevTime = tmp;
			currentTime += duration;
			frame++;
			
			durationList.unshift(duration);
			sumtime += duration - (durationList.length>FPS? durationList.pop() : 0);
			actualFPS = frame%20==0? durationList.length / sumtime : actualFPS;
			sleep += 1.0/FPS - duration;
			
			return Q.wait(Std.int(sleep>0? 1000*sleep : sleep = 0));
		}));
	}
}