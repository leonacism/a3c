package a3c.ai.actor;

import a3c.ai.common.Config;
import a3c.ai.common.MathUtil;
import a3c.ai.learning.Learner;
import a3c.ai.learning.Worker;
import q.Channel;
import q.Q;

/**
 * ...
 * @author leonaci
 */
enum Mode {
	Train;
	Enjoy;
}

class Agent {
	private var game:Game;
	private var learner:Learner;
	private var global:Worker;
	
	private var process:Array<Cont<Dynamic>>;
	private var observation:{state:Dynamic, action:Dynamic, reward:Dynamic, next_state:Dynamic, initial:Dynamic, terminal:Bool};
	private var memory:Array<{state:Dynamic, action:Dynamic, reward:Dynamic, next_state:Dynamic, initial:Dynamic, terminal:Bool}>;
	
	public inline function new(game:Game, global:Worker) {
		this.game = game;
		this.learner = new Learner(global);
		this.global = global;
		this.memory = [];
	}
	
	public inline function init(mode:Mode) return switch(mode) {
		case Mode.Train:
			Q.build({
				//Gameのstateを観測する
				var state_observer = return Channel.spawn(receiver -> Q.build({
					while(true) this.observation = return receiver.receive();
				}));
				
				//Gameにstateをrequestする
				var state_requester = return Channel.spawn(receiver -> Q.build({
					while(true) {
						var _ = return receiver.receive();
						return game.state_notifier.send(state_observer);
					}
				}));
				
				//(Gameによって要請される)一定の条件が満たされれば行動する。(何もしないという行動も含む)
				var actor = return Channel.spawn(receiver -> Q.build({
					while(true) {
						var _ = return receiver.receive();
						if(observation.terminal) return game.action_observer.send(null);
						else {
							var value:Array<Float> = learner.value([observation.next_state])[1][0];
							var policy = MathUtil.softmax(value);
							var r = Math.random(), b = true;
							for(i in 0...policy.length) if((r-=policy[i])<0&&b) {
								return game.action_observer.send(i);
								b=false;
							}
						}
					}
				}));
				
				
				this.process = [
					Current.start(Q.build({
						while(true) {
							return Q.wait(0);
							return state_requester.send(null);
						}
					}), 30.0),
					Current.start(Q.build({
						while (true) {
							learner.copyParams();
							return Q.wait(0);
							return actor.send(null);
							return Q.wait(0);
							
							if (!observation.initial) {
								memory.unshift(observation);
								
								if (memory.length == Config.UPDATE_FREQUENCY || observation.terminal) {
									learner.updateGrads(memory);
									memory = [];
								}
							}
						}
					}), 60.0),
				];
				
				trace('agent initialized.');
			});
			
		case Mode.Enjoy:
			Q.build({
				//Gameのstateを観測する
				var state_observer = return Channel.spawn(receiver -> Q.build({
					while(true) this.observation = return receiver.receive();
				}));
				
				//Gameにstateをrequestする
				var state_requester = return Channel.spawn(receiver -> Q.build({
					while(true) {
						var _ = return receiver.receive();
						return game.state_notifier.send(state_observer);
					}
				}));
				
				//(Gameによって要請される)一定の条件が満たされれば行動する。(何もしないという行動も含む)
				var actor = return Channel.spawn(receiver -> Q.build({
					var score = 0.0;
					while(true) {
						var _ = return receiver.receive();
						
						score += observation.reward;
						
						if (observation.terminal) {
							trace(score);
							score = 0;
							return game.action_observer.send(null);
						}
						else {
							var value:Array<Float> = learner.value([observation.next_state])[1][0];
							var policy = MathUtil.softmax(value);
							var r = Math.random(), b = true;
							for(i in 0...policy.length) if((r-=policy[i])<0&&b) {
								return game.action_observer.send(i);
								b=false;
							}
						}
					}
				}));
				
				
				this.process = [
					Current.start(Q.build({
						while(true) {
							return Q.wait(0);
							return state_requester.send(null);
						}
					}), 30.0),
					Current.start(Q.build({
						while(true) {
							learner.copyParams();
							return Q.wait(0);
							return actor.send(null);
							return Q.wait(0);
							return game.renderer.send(null);
						}
					}), 60.0),
				];
				
				trace('agent initialized.');
			});
	}
	
	public inline function start() {
		return Q.fork(Q.build({
			for(p in process) return Q.fork(p);
		}));
	}
}