package a3c.demo;
import a3c.ai.actor.Game;
import gym.Env;
import gym.Gym;
import gym.ID;
import q.Channel;
import q.Q;

/**
 * ...
 * @author leonaci
 */

class Gym extends Game {
	private var id:ID;
	private var env:Env;
	private var state:Dynamic;
	
	public inline function new(id:ID) this.id = id;
	
	override public function init() {
		return Q.build({
			this.env = gym.Gym.make(id);
			
			//actorから与えられた行動からstateを定義し、維持する
			this.action_observer = return Channel.spawn(receiver -> return Q.build({
				while(true) {
					var action = return receiver.receive();
					
					if(action!=null) {
						var current_state = this.state.next_state;
						var v = env.step(action);
						var reward = v[1];
						var next_state = v[0];
						var terminal = v[2];
						this.state = {state:current_state, action:action, reward:reward, next_state:next_state, initial:false, terminal:terminal};
					}
					else {
						var next_state = env.reset();
						this.state = {next_state:next_state, reward:0, initial:true, terminal:false};
					}
				}
			}));
			
			//request元にstateを通知する
			this.state_notifier = return Channel.spawn(receiver -> return Q.build({
				while(true) {
					var observer = return receiver.receive();
					return observer.send(state);
				}
			}));
			
			//Gameを初期化する
			this.initializer = return Channel.spawn(receiver -> return Q.build({
				while (true) {
					var _ = return receiver.receive();
					var next_state = env.reset();
					this.state = {reward:0, next_state:next_state, initial:true, terminal:false};
				}
			}));
			
			//Gameを描画する
			this.renderer = return Channel.spawn(receiver -> return Q.build({
				while(true) {
					var _ = return receiver.receive();
					env.render();
				}
			}));
			
			return this.initializer.send(null);
			
			trace('game initialized.');
		});
	}
}