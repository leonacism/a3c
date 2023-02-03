package rigid.dynamics.collision;
import rigid.dynamics.collision.narrowphase.Detector;
import rigid.dynamics.constraint.ContactConstraint;

/**
 * ...
 * @author leo
 */
enum Contact {
	YET(detector:Detector);
	TRUE(contactConstraint:ContactConstraint);
	FALSE;
}

abstract Pair(Contact) to Contact {
	inline function new(c:Contact) this = c;
	
	@:from
	static public inline function from(c:Contact) return new Pair(c);
	
	public inline function detach() this = null;
	
	public inline function updateContact() {
		// 衝突しているかどうかを判定し、衝突しているなら衝突情報を計算し、拘束条件を生成する。
		this = switch(this) {
			case Contact.YET(detector): detector.detect();
			case _: throw 'Already Judged.';
		}
	}
}