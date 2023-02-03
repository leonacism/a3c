package rigid.dynamics.collision;
import rigid.dynamics.collision.broadphase.BroadPhase;
import rigid.dynamics.collision.broadphase.BroadPhase.BroadPhaseType;
import rigid.dynamics.collision.broadphase.BruteForceBroadPhase;
import rigid.dynamics.collision.narrowphase.NarrowPhase;

/**
 * ...
 * @author leo
 */
class PairManager {
	public var pairs:Array<Pair>;
	
	public var broadPhase(default, null):BroadPhase;
	public var narrowPhase(default, null):NarrowPhase;

	public function new(type:BroadPhaseType) {
		this.pairs = [];
		
		this.broadPhase = switch(type) {
			case BruteForce: new BruteForceBroadPhase();
		}
		
		this.narrowPhase = new NarrowPhase();
	}
	
	@:extern
	public inline function broadJudge() {
		//collect new pairs
		broadPhase.updatePairs();
		
		//create pairs
		var pairs_ = broadPhase.pairs;
		for (p_ in pairs_) {
			//重複ペアがないか探す
			var found = false;
			if (!found) pairs.push(p_);
		}
		
		//destroy seperated pairs
		for (p in pairs.copy()) {
			var touching = true;
			if (!touching) removePair(p);
		}
	}
	
	@:extern
	public inline function narrowJudge() {
		pairs = [for (p in pairs) {p.updateContact(); p;}];
	}
	
	public inline function removePair(p:Pair) {
		pairs.remove(p);
		p.detach();
	}
}




