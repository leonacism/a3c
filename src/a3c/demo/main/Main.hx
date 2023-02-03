package a3c.demo.main;

import a3c.ai.actor.Agent;
import a3c.ai.common.Config;
#if python
import a3c.ai.learning.local.LocalWorker;
import a3c.demo.Gym;
import gym.ID;
#elseif js
import a3c.ai.learning.remote.RemoteWorker;
#end
import q.Q;

/**
 * ...
 * @author leonaci
 */
class Main {
	static function main() {
		Q.run(process());
	}
	
	static function process() {
		return Q.build({
			var global = #if python new LocalWorker('global'); #elseif js new RemoteWorker('global'); #end
			
			for(i in 0...Config.WORKERS) return Q.fork(Q.build({
				var game = #if python new Gym(ID.CartPoleV1); #elseif js new CartPole(); #end
				var agent = new Agent(game, global);
				
				return game.init();
				return agent.init(Mode.Train);
				
				return agent.start();
			}));
			
			return Q.fork(Q.build({
				var game = #if python new Gym(ID.CartPoleV1); #elseif js new CartPole(); #end
				var agent = new Agent(game, global);
				
				return game.init();
				return agent.init(Mode.Enjoy);
				
				return agent.start();
			}));
		});
	}
}
