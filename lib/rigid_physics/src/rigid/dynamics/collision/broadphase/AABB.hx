package rigid.dynamics.collision.broadphase;
import rigid.common.Vec2;

/**
 * ...
 * @author leo
 */
class AABB {
	public var max(default, default):Vec2;
	public var min(default, default):Vec2;

	public function new() {
		this.max = new Vec2(0.0, 0.0);
		this.min = new Vec2(0.0, 0.0);
	}
}