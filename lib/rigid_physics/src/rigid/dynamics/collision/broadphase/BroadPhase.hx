package rigid.dynamics.collision.broadphase;
import rigid.dynamics.body.Body;
import rigid.dynamics.collision.Pair;

/**
 * ...
 * @author leo
 */
enum BroadPhaseType {
	BruteForce;
}

class BroadPhase {
	public var pairs:Array<Pair>;
	public var bodies:Array<Body>;
	
	public function new() {
		this.pairs = [];
		this.bodies = [];
	}
	
	public function updatePairs() throw 'Not Implemented.';
	
	public function addBody(body:Body) {
		bodies.push(body);
		body.sync();
	}
	
	public function removeBody(body:Body) {
		bodies.remove(body);
	}
}