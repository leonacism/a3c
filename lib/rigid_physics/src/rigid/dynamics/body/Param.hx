package rigid.dynamics.body;
import rigid.common.Vec2;
import util.MFloat;

/**
 * All physical parameters that characterize the physical state of the rigid body.
 * @author leo
 */
class Param {
	public var q:Vec2; //linear position
	public var p:Vec2; //linear momentum
	public var aq:Float; //anguler position
	public var ap:Float; //anguler momentum
	
	public var mass:MFloat; //mass
	public var inertia:MFloat; //inertia

	public function new() {
		q = new Vec2(0.0, 0.0);
		p = new Vec2(0.0, 0.0);
		aq = 0.0;
		ap = 0.0;
		mass = 0.0;
		inertia = 0.0;
	}
	
}