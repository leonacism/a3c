package a3c.ai.learning;
#if python
import a3c.ai.learning.local.LocalWorker;
#elseif js
import a3c.ai.learning.remote.RemoteWorker;
#end

/**
 * ...
 * @author leonaci
 */
class Learner
{
	static private var WORKER_UID:Int = 0;
	private var uid:String;
	
	private var local:Worker;
	private var global:Worker;
	
	public function new(global:Worker) {
		uid = '${WORKER_UID++}';
		local = #if js new RemoteWorker(uid); #elseif python new LocalWorker(uid); #end
		this.global = global;
	}
	
	public function value(input:Dynamic):Dynamic {
		return local.value(input);
	}
	
	public function copyParams():Void {
		//global parameterをlocalにcopyする
		local.copyParams(global);
	}
	
	public function updateGrads(observations:Dynamic):Void {
		local.updateGrads(observations, global);
	}
}