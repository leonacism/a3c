package rigid.dynamics.collision.broadphase;
import rigid.dynamics.body.Body;
import rigid.dynamics.collision.Pair;
import rigid.dynamics.collision.broadphase.BroadPhase;
import rigid.dynamics.collision.narrowphase.Detector;

/**
 * ...
 * @author leo
 */

class BruteForceBroadPhase extends BroadPhase {

	public function new() {
		super();
	}
	
	override public inline function updatePairs() {
		this.pairs = [];
		for (i in 1...bodies.length) for (j in 0...i) {
			var b1 = bodies[i], b2 = bodies[j];
			if (overlap(b1, b2)) {
				var pair = YET(new Detector(b1, b2));
				this.pairs.push(pair);
			}
		}
	}
	
	private inline function overlap(b1:Body, b2:Body) {
		var max1 = b1.shape.aabb.max,
			max2 = b2.shape.aabb.max,
			min1 = b1.shape.aabb.min,
			min2 = b2.shape.aabb.min;
		
		return (
			min1.x<max2.x && max1.x>min2.x &&
			min1.y<max2.y && max1.y>min2.y
		);
	}
}