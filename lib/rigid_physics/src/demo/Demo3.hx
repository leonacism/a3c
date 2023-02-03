package demo;
import rigid.dynamics.World;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.shape.SphereShape;
import rigid.dynamics.constraint.DistanceConstraint;
import rigid.dynamics.constraint.MouseConstraint;
import rigid.common.MathUtil;
import rigid.common.Vec2;

/**
 * ...
 * @author leo
 */
class Demo3 extends Demo {

	static public function main():Void {
		new Demo3().start();
	}
	
	private function new() {}
	
	override inline function init() {
		var r = 20;
		var b = new Body(new SphereShape(r));
		b.mass = 1E-05 * r * r * MathUtil.PI;
		b.q = {x:150.0, y:100.0};
		b.v = {x:0.0, y:0.0};
		
		world.addBody(b);
		
		world.addConstraint(new MouseConstraint(b, {x:0.0, y:200.0}));
	}
	
	override inline function update() {
		for (b in world.bodies) {
			var x = b.q.x, y = b.q.y;
			
			if(b.q.x>g.WIDTH/1.2) x = -g.WIDTH/1.2; else if(b.q.x<-g.WIDTH/1.2) x = g.WIDTH/1.2;
			if(b.q.y>g.HEIGHT/1.2) y = -g.HEIGHT/1.2; else if(b.q.y<-g.HEIGHT/1.2) y = g.HEIGHT/1.2;
		}
	}
}