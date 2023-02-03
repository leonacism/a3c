package rigid.dynamics.body.shape;
import rigid.common.Vec2;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.Transform;
import rigid.dynamics.body.shape.Shape;
import rigid.dynamics.collision.broadphase.AABB;

/**
 * ...
 * @author leo
 */
class SphereShape implements Shape {
	public var aabb(default, null):AABB;
	public var kind(default, null):ShapeKind;
	
	// inertia per mass unit
	public var inertia(get, never):Float;
	inline function get_inertia():Float return 1 / 2 * radius * radius;
	
	public var radius:Float;

	public function new(radius:Float) {
		aabb = new AABB();
		kind = ShapeKind.Sphere;
		this.radius = radius;
	}
	
	public inline function calcAABB(transform:Transform) {
		var r:Vec2 = new Vec2(radius, radius);
		var o = transform.q;
		aabb.max = o + r;
		aabb.min = o - r;
	}
}