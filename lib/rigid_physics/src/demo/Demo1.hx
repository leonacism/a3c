package demo;
import rigid.common.MathUtil;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.shape.SphereShape;

/**
 * ...
 * @author leo
 */
class Demo1 extends Demo {
	
	static public function main():Void {
		new Demo1().start();
	}
	
	function new() {}
	
	override inline function init() {
		for (i in 0...100) {
			world.underGravity = false;
			
			var r = (MathUtil.rnd()+MathUtil.rnd()+MathUtil.rnd())*10 + 5;
			
			var b = new Body(new SphereShape(r));
			b.mass = 1E-05 * r * r * MathUtil.PI;
			b.q = {x:(MathUtil.rnd() - 0.5) * g.WIDTH, y:(MathUtil.rnd() - 0.5) * g.HEIGHT};
			b.v = {x:(MathUtil.rnd() - 0.5) * 1E3, y:(MathUtil.rnd() - 0.5) * 1E3}; 
			
			world.addBody(b);
		}
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