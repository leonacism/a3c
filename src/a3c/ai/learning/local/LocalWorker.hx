package a3c.ai.learning.local;

import a3c.ai.learning.Worker;
import a3c.ai.learning.local.UpdateGrads.UpdateGradsModule;

/**
 * ...
 * @author leonaci
 */
class LocalWorker implements Worker
{
	private var uid:String;
	private var model:Model;
	
	public function new(uid:String) {
		this.uid = uid;
		model = new Model(uid);
	}
	
	public function value(input:Dynamic):Dynamic {
		return this.model.value(input);
	}
	
	public function serialize():Void {
		this.model.serialize();
	}
	
	public function copyParams(source:Worker):Void {
		var source:LocalWorker = Std.downcast(source, LocalWorker);
		this.model.copy_params(source.model);
	}
	
	public function updateGrads(observations:Array<Dynamic>, target:Worker):Void {
		var target:LocalWorker = Std.downcast(target, LocalWorker);
		
		var episode = python.Lib.anonAsDict({
			"memory" : [for(o in observations) python.Lib.anonAsDict({
				"state" : o.state,
				"action" : o.action,
				"reward" : o.reward
			})],
			"last_state" : observations[0].next_state,
			"terminal" : observations[0].terminal
		});
		
		this.model.update_grads(episode);
		UpdateGradsModule.update_grads(target, this, episode);
		trace('a');
	}
}
