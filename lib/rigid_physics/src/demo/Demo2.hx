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
class Demo2 extends Demo {
	
	static public function main():Void {
		new Demo2().start();
	}
	
	private function new() {}
	
	override inline function init() {
		var r = 20;
		var b2 = new Body(new SphereShape(r));
		b2.mass = 1E-05 * r * r * MathUtil.PI;
		b2.q = {x:0.0, y:350.0};
		b2.v = {x:0.0, y:0.0};
		
		world.addBody(b2);
		
		var r = 10;
		var b3 = new Body(new SphereShape(r));
		b3.mass = 1E-05 * r * r * MathUtil.PI;
		b3.q = {x:100.0, y:350.0};
		b3.v = {x:0.0, y:0.0}; 
		
		world.addBody(b3);
		
		world.addConstraint(new MouseConstraint(b2, {x:0.0, y:200.0}));
		world.addConstraint(new DistanceConstraint(b2, b3));
	}
	
	override inline function update() {
		for (b in world.bodies) {
			var x = b.q.x, y = b.q.y;
			
			if(b.q.x>g.WIDTH/1.2) x = -g.WIDTH/1.2; else if(b.q.x<-g.WIDTH/1.2) x = g.WIDTH/1.2;
			if(b.q.y>g.HEIGHT/1.2) y = -g.HEIGHT/1.2; else if(b.q.y<-g.HEIGHT/1.2) y = g.HEIGHT/1.2;
			
			b.q = {x:x, y:y};
		}
	}
}