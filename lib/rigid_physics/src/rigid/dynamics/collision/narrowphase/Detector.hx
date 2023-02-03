package rigid.dynamics.collision.narrowphase;
import rigid.dynamics.body.shape.ShapeKind;
import rigid.dynamics.collision.Pair;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.shape.Shape;
import rigid.dynamics.collision.Pair.Contact;
import rigid.dynamics.constraint.ContactConstraint;

/**
 * ...
 * @author leo
 */
 
class Detector {
	var impl:DetectorImpl;
	
	public function new(b1:Body, b2:Body) {
		var s1 = b1.shape, s2 = b2.shape;
		this.impl = switch(s1.kind) {
			case ShapeKind.Sphere:
				switch(s2.kind) {
					case ShapeKind.Sphere: new SphereSphereDetector(b1, b2);
				}
		};
	}
	
	@:extern
	public inline function detect() return impl.detect();
}