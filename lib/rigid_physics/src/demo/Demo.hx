package demo;
import js.Browser;
import js.html.CanvasElement;
import js.html.KeyboardEvent;
import js.html.MouseEvent;
import rigid.common.MathUtil;
import rigid.common.Vec2;
import rigid.dynamics.World;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.shape.Shape;
import rigid.dynamics.body.shape.ShapeKind;
import rigid.dynamics.body.shape.SphereShape;
import rigid.dynamics.constraint.Constraint;
import rigid.dynamics.constraint.ContactConstraint;
import util.Graphics;
import util.MainLoop;
import util.js.GraphicsJS;
import util.js.KeyManagerJS;
import util.js.MouseManagerJS;

/**
 * ...
 * @author leo
 */
class Demo {
	static private var WIDTH:Int = 800;
	static private var HEIGHT:Int = 800;
	
	private var world:World;
	private var canvas:CanvasElement;
	private var g:Graphics;
	private var m:MouseManagerJS;
	private var k:KeyManagerJS;

	private var mx:Float;
	private var my:Float;
	private var premx:Float;
	private var premy:Float;
	private var isDown:Bool;
	
	private var isPress:Bool;
	
	private var debug:Bool;
	
	private function start() {
		initDemo();
		initGUI();
		
		MainLoop.init = this.init;
		
		MainLoop.input = function() {}
		
		MainLoop.update = function() {
			world.step(1 / MainLoop.FPS);
			this.update();
		}
		
		MainLoop.render = this.render;
		
		MainLoop.start();
	}
	
	private inline function initDemo() {
		this.world = new World();
		this.canvas = cast Browser.document.getElementById('canvas');
		canvas.width = WIDTH;
		canvas.height = HEIGHT;
		this.g = new GraphicsJS(canvas);
		this.debug = true;
	}
	
	private inline function initGUI() {
		this.m = new MouseManagerJS(canvas);
		this.k = new KeyManagerJS(canvas);
		
		this.mx = 0.0; this.my = 0.0;
		this.premx = 0.0; this.premy = 0.0;
		this.isDown = false;
		
		this.isPress = false;
		
		m.onMouseMove(function(e:MouseEvent) {
			var rect = canvas.getBoundingClientRect();
			premx = mx; premy = my;
			mx = e.clientX - rect.left;
			my = e.clientY - rect.top;
			input();
		});
		
		m.mouseDown(function(e:MouseEvent) {
			if (e.button == 0) isDown = true;
		});
		
		m.mouseUp(function(e:MouseEvent) {
			if (e.button == 0) isDown = false;
		});
		
		k.onKeyDown(function(e:KeyboardEvent) {
			trace('a');
		});
		
		k.onKeyUp(function(e:KeyboardEvent) {
			
		});
	}
	
	private function init() throw 'Not Implemented';

	private function update() throw 'Not Implemented';

	private inline function input() {}

	private inline function render() {
			g.background(255, 255, 255);
			for (b in world.bodies) drawBody(b);
			for (c in world.constraints) {
				if(Std.is(c, ContactConstraint)) drawContact(cast(c,ContactConstraint));
				else drawConstraint(c);
			}
			
			if(debug) {
				g.color(0, 0, 0);
				g.text('FPS : ' + MainLoop.actualFPS, -g.WIDTH/2, g.HEIGHT/2-15, 50);
				g.text('Bodies : ' + world.bodies.length, -g.WIDTH/2, g.HEIGHT/2-30, 50);
				g.text('Constraints : ' + world.constraints.length, -g.WIDTH/2, g.HEIGHT/2-45, 50);
				g.text('Energy : ' + getEnergy(), -g.WIDTH/2, g.HEIGHT/2-60, 50);
			}
	}
	
	private function drawBody(b:Body) {
		var s:Vec2 = new Vec2(g.WIDTH, g.HEIGHT);
		switch(b.shape.kind) {
			case ShapeKind.Sphere:
				var q = b.q;
				var r = cast(b.shape, SphereShape).radius;
				
				g.color(250, 200, 200);
				g.arc(b.q.x, b.q.y, Std.int(r));
				
				g.color(0, 0, 0);
				g.line(b.q.x, b.q.y, b.q.x+r*MathUtil.cos(b.qa), b.q.y+r*MathUtil.sin(b.qa));
		}
	}
	
	private function drawAABB(b:Body) {
		var s:Vec2 = new Vec2(g.WIDTH, g.HEIGHT);
		var v = b.q + 0.5 * s, ma = b.shape.aabb.max, mi = b.shape.aabb.min;
		
		g.color(0, 0, 0);
		g.line(mi.x, mi.y, ma.x, mi.y);
		g.line(ma.x, mi.y, ma.x, ma.y);
		g.line(ma.x, ma.y, mi.x, ma.y);
		g.line(mi.x, ma.y, mi.x, mi.y);
	}
	
	private function drawContact(c:ContactConstraint) {
		var c1 = c.rq1 + c.p1.q, c2 = c.rq2 + c.p2.q;
		
		g.color(255, 0, 0);
		g.point(c1.x, c1.y, 2);
		g.point(c2.x, c2.y, 2);
	}
	
	private function drawConstraint(c:Constraint) {
		var c1 = c.p1.q, c2 = c.p2.q;
		
		g.color(255, 0, 0);
		g.line(c1.x, c1.y, c2.x, c2.y);
	}
	
	private function getEnergy() {
		var energy = 0.0;
		for (b in world.bodies) {
			energy += 0.5*b.mass*b.v*b.v + 0.5*b.inertia*b.va*b.va;
		}
		return energy;
	}
}