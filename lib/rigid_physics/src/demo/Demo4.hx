package demo;
import rigid.common.MathUtil;
import rigid.common.Vec2;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.shape.SphereShape;
import rigid.dynamics.constraint.CylindricalConstraint;
import rigid.dynamics.constraint.DistanceConstraint;

/**
 * ...
 * @author leo
 */
class Demo4 extends Demo {
	var t:Int;
	var b1:Body;
	var b2:Body;
	var b3:Body;
	var b4:Body;
	
	static public function main():Void {
		new Demo4().start();
	}
	
	private function new() {}
	
	override inline function init() {
		t = 0;
		
		var r = 0;
		b1 = new Body(new SphereShape(r));
		b1.mass = 1E-02 * r * r * MathUtil.PI;
		b1.q = new Vec2(0.0, -100.0);
		b1.v = new Vec2(0.0, 0.0);
		
		world.addBody(b1);
		
		var r = 10;
		b2 = new Body(new SphereShape(r));
		b2.mass = 1.0 * r * r * MathUtil.PI;
		b2.q = new Vec2(0.0, -100.0);
		b2.v = new Vec2(0.0, 0.0);
		
		world.addBody(b2);
		
		var r = 10;
		b3 = new Body(new SphereShape(r));
		b3.mass = 1E-03 * r * r * MathUtil.PI;
		b3.q = new Vec2(0.0, -250.0);
		b3.v = new Vec2(20.0*(2.0*MathUtil.rnd()-1.0), 20.0*(2.0*MathUtil.rnd()-1.0));
		
		world.addBody(b3);
		
		var r = 10;
		b4 = new Body(new SphereShape(r));
		b4.mass = 1E-04 * r * r * MathUtil.PI;
		b4.q = new Vec2(0.0, -350.0);
		b4.v = new Vec2(20.0*(2.0*MathUtil.rnd()-1.0), 20.0*(2.0*MathUtil.rnd()-1.0));
		
		world.addBody(b4);
		
		world.addConstraint(new CylindricalConstraint(b1, b2, new Vec2(1.0, 0.0)));
		world.addConstraint(new DistanceConstraint(b2, b3));
		world.addConstraint(new DistanceConstraint(b3, b4));
	}
	
	override inline function update() {
		t++;
		b2.v += 5e3*MathUtil.cos(2*MathUtil.PI*t/60)*(new Vec2(1.0, 0.0))/b2.mass;
	}
}