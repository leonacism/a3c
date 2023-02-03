package rigid.dynamics.collision.narrowphase;
import rigid.dynamics.collision.Pair;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.shape.Shape;
import rigid.dynamics.collision.Pair.Contact;

/**
 * ...
 * @author leo
 */
class DetectorImpl {
	var b1:Body;
	var b2:Body;

	public function new() {}

	public function detect():Contact throw 'Not Implemented.';
}