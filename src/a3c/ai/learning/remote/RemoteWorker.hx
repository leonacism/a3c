package a3c.ai.learning.remote;
import a3c.ai.common.Config;
import a3c.ai.learning.Worker;
import haxe.Json;
import js.Browser;
import js.html.Response;

/**
 * ...
 * @author leonaci
 */
class RemoteWorker implements Worker
{
	private var uid:String;
	private var output:Dynamic;
	private var params:Dynamic;
	
	public function new(uid:String) {
		this.uid = uid;
		this.output = [[[0.0]], [[0.0, 0.0]]];
		
		createWorker(uid);
	}

	public function value(input:Dynamic):Dynamic {
		Browser.window.fetch('http://${Config.HOST}:${Config.PORT}/api/value', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
			},
			body: '{
				"id" : "${uid}",
				"input" : ${input}
			}',
		})
		.then(res->{
			var res:Response = res;
			res.text().then(text->{
				this.output = Json.parse(text);
				trace(Std.string(output));
			});
		});
		
		return output;
	}

	public function serialize():Void {
		Browser.window.fetch('http://${Config.HOST}:${Config.PORT}/api/serialize', {
			method: 'PUT',
			headers: {
				'Content-Type': 'application/text',
			},
			body: '{
				"id" : "${uid}"
			}',
		});
	}

	public function copyParams(source:Worker):Void {
		var source:RemoteWorker = Std.downcast(source, RemoteWorker);
		Browser.window.fetch('http://${Config.HOST}:${Config.PORT}/api/copy-params', {
			method: 'PUT',
			headers: {
				'Content-Type': 'application/text',
			},
			body: '{
				"target_id" : "${this.uid}",
				"source_id" : "${source.uid}"
			}',
		});
	}

	public function updateGrads(observations:Array<Dynamic>, target:Worker):Void {
		var target:RemoteWorker = Std.downcast(target, RemoteWorker);
		
		var episode = {
			"memory" : [for(o in observations) {
				"state" : o.state,
				"action" : o.action,
				"reward" : o.reward
			}],
			"last_state" : observations[0].next_state,
			"terminal" : observations[0].terminal
		};
		
		Browser.window.fetch('http://${Config.HOST}:${Config.PORT}/api/update-grads', {
			method: 'PUT',
			headers: {
				'Content-Type': 'application/text',
			},
			body: '{
				"target_id" : "${target.uid}",
				"source_id" : "${uid}",
				"episode" : ${Json.stringify(episode)}
			}',
		});
	}

	private function createWorker(uid:String):Void {
		Browser.window.fetch('http://${Config.HOST}:${Config.PORT}/api/worker', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
			},
			body: '{
				"id" : "${uid}"
			}',
		});
	}
}
