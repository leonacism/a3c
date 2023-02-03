package rigid.dynamics;
import rigid.common.Vec2;
import rigid.dynamics.body.Body;
import rigid.dynamics.collision.Pair.Contact;
import rigid.dynamics.collision.PairManager;
import rigid.dynamics.collision.broadphase.BroadPhase;
import rigid.dynamics.constraint.Constraint;
import rigid.dynamics.constraint.ContactConstraint;
/**
 * ...
 * @author leo
 */
class World {
	public var underGravity:Bool;
	public var bodies(default, null):Array<Body>;
	public var constraints(default, null):Array<Constraint>;
	
	private var pairManager:PairManager;
	
	public function new() {
		this.underGravity = true;
		this.bodies = [];
		this.constraints = [];
		this.pairManager = new PairManager(BroadPhaseType.BruteForce);
	}
	
	public function addBody(body:Body) {
		bodies.push(body);
		pairManager.broadPhase.addBody(body);
	}
	
	public function removeBody(body:Body) {
		bodies.remove(body);
		pairManager.broadPhase.removeBody(body);
	}
	
	public function addConstraint(constraint:Constraint) {
		constraints.push(constraint);
	}
	
	public function removeConstraint(constraint:Constraint) {
		constraints.remove(constraint);
	}
	
	@:extern
	public inline function step(dt:Float) {
		if(underGravity) for (b in bodies) b.transform.p += b.mass * new Vec2(0.0, -100.0);
		
		detectConstraints();
		solveConstraints(dt);
		integrate(dt);
	}

	@:extern
	private inline function detectConstraints() {
		//broad phase collision judgement
		pairManager.broadJudge();
		
		//narrow phase collision judgement
		pairManager.narrowJudge();
		
		//update constraints
		for (p in pairManager.pairs.copy()) {
			switch(p:Contact) {
				case TRUE(cc): constraints.push(cc);
				case FALSE:
				case YET(_): throw 'Not Yet Judged.';
			}
			pairManager.removePair(p);
		}
	}
	
	@:extern
	private inline function solveConstraints(dt:Float) {
		for(c in constraints) c.presolve(dt);
		for(c in constraints) c.solveMoment();
		removeContacts();
	}
	
	@:extern
	private inline function integrate(dt:Float) {
		for (b in bodies) {
			b.integrate(dt);
			b.sync();
		}
	}
	
	private inline function removeContacts() {
		for(c in constraints) if(Std.is(c, ContactConstraint)) this.removeConstraint(c);
	}
}