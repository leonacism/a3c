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
class Demo5 extends Demo {
	var t:Int;
	var c:Body;
	
	static public function main():Void {
		new Demo5().start();
	}
	
	private function new() {}
	
	override inline function init() {
		t = 0;
		
		var r = 0;
		var fix = new Body(new SphereShape(r));
		fix.mass = 0;
		fix.q = new Vec2(0.0, 0.0);
		fix.v = new Vec2(0.0, 0.0);
		
		world.addBody(fix);
		
		var r = 10;
		c = new Body(new SphereShape(r));
		c.mass = 1.0 * r * r * MathUtil.PI;
		c.q = new Vec2(0.0, 0.0);
		c.v = new Vec2(0.0, 0.0);
		
		world.addBody(c);
		
		var r = 10;
		var b1 = new Body(new SphereShape(r));
		b1.mass = 1E-03 * r * r * MathUtil.PI;
		b1.q = new Vec2(0.0, 100.0);
		b1.v = new Vec2(20.0*(2.0*MathUtil.rnd()-1.0), 20.0*(2.0*MathUtil.rnd()-1.0));
		
		world.addBody(b1);
		
		world.addConstraint(new CylindricalConstraint(fix, c, new Vec2(1.0, 0.0)));
		world.addConstraint(new DistanceConstraint(c, b1));
	}
	
	override inline function update() {
		t++;
		c.v += 5e3*MathUtil.cos(2*MathUtil.PI*t/60)*(new Vec2(1.0, 0.0)) / c.mass;
	}
}