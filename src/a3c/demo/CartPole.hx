package a3c.demo;
import a3c.ai.actor.Game;
import js.Browser;
import pixi.core.display.DisplayObjectContainer;
import pixi.core.graphics.FillColor;
import pixi.core.graphics.Graphics;
import pixi.core.renderer.Renderer;
import pixi.util.Color;
import q.Channel;
import q.Q;
import rigid.common.MathUtil;
import rigid.common.Vec2;
import rigid.dynamics.World;
import rigid.dynamics.body.Body;
import rigid.dynamics.body.shape.ShapeKind;
import rigid.dynamics.body.shape.SphereShape;
import rigid.dynamics.constraint.Constraint;
import rigid.dynamics.constraint.ContactConstraint;
import rigid.dynamics.constraint.CylindricalConstraint;
import rigid.dynamics.constraint.DistanceConstraint;

/**
 * ...
 * @author leonaci
 */

class CartPole extends Game {
	static var WIDTH:Int = 1200;
	static var HEIGHT:Int = 800;
	
	private var ctx:Renderer;
	private var stage:DisplayObjectContainer;
	private var g:Graphics;
	
	private var state:Dynamic;
	private var world:World;
	private var c:Body;
	private var b1:Body;
	
	public inline function new() {
		prepareLogic();
		prepareView();
	}
	
	private function prepareLogic():Void {
		this.world = new World();
		
		var r = 0;
		var fix = new Body(new SphereShape(r));
		fix.mass = 0;
		fix.q = new Vec2(0.0, 0.0);
		fix.v = new Vec2(0.0, 0.0);
		
		world.addBody(fix);
		
		var r = 40;
		c = new Body(new SphereShape(r));
		c.mass = 1.0 * r * r * MathUtil.PI;
		c.q = new Vec2(0.0, 0.0);
		c.v = new Vec2(0.0, 0.0);
		
		world.addBody(c);
		
		var r = 20;
		b1 = new Body(new SphereShape(r));
		b1.mass = 1E-03 * r * r * MathUtil.PI;
		b1.q = new Vec2(0.0, 200.0);
		b1.v = new Vec2(0.0, 0.0);
		
		world.addBody(b1);
		
		world.addConstraint(new CylindricalConstraint(fix, c, new Vec2(1.0, 0.0)));
		world.addConstraint(new DistanceConstraint(c, b1));
	}
	
	private function prepareView():Void {
		this.ctx = new Renderer(WIDTH, HEIGHT, {
			autoResize: true,
			backgroundColor: 0xEEEEEE,
		});
		
		function resize() {
			var aspectWidth = Browser.window.innerWidth / WIDTH;
			var aspectHeight = Browser.window.innerHeight / HEIGHT;
			var aspect = (aspectWidth > aspectHeight)? aspectHeight : aspectWidth;
			var canvas = ctx.view;
			canvas.style.position = 'absolute';
			canvas.style.margin = 'auto';
			canvas.style.width  = '${WIDTH * aspect}px';
			canvas.style.height = '${HEIGHT * aspect}px';
			canvas.style.top = '0px';
			canvas.style.left = '0px';
			canvas.style.bottom = '0px';
			canvas.style.right = '0px';
		}
		resize();
		Browser.window.onresize = resize;
		
		Browser.document.body.appendChild(ctx.view);
		
		this.stage = new DisplayObjectContainer();
		
		this.g = new Graphics();
		g.x = WIDTH/2;
		g.y = HEIGHT/2;
		
		g.addFrameHandler(()->{
			g.clear();
			for (b in world.bodies) drawBody(b);
			for (c in world.constraints) {
				if(Std.is(c, ContactConstraint)) drawContact(cast(c,ContactConstraint));
				else drawConstraint(c);
			}
		});
		
		stage.addChild(g);
	}
	
	override public function init() {
		return Q.build({
			var terminal:Bool = false;
			
			//actorから与えられた行動からstateを定義し、維持する
			this.action_observer = return Channel.spawn(receiver -> Q.build({
				while(true) {
					var action = return receiver.receive();
					if (terminal) {
						return initializer.send(null);
						terminal = false;
					}
					else {
						var current_state = this.state.next_state;
						var v = switch(action) {
							case 0: -10;
							case 1:  10;
							default:   0;
						}
						c.v += new Vec2(v, 0.0);
						world.step(1 / 60);
						
						terminal = (MathUtil.abs(c.q.x) > 500 || b1.q.y < 0);
						var next_state = [c.q.x/200, c.v.x/200, 2*MathUtil.atan((b1.q.y-c.q.y)/(b1.q.x-c.q.x))/MathUtil.PI, MathUtil.sqrt(b1.v*b1.v)/1000];
						var reward = 1.0;
						this.state = {state:current_state, action:action, reward:reward, next_state:next_state, initial:false, terminal:terminal};
					}
				}
			}));
			
			//request元にstateを通知する
			this.state_notifier = return Channel.spawn(receiver -> Q.build({
				while(true) {
					var observer = return receiver.receive();
					return observer.send(state);
				}
			}));
			
			//Gameを初期化する
			this.initializer = return Channel.spawn(receiver -> Q.build({
				while (true) {
					var _ = return receiver.receive();
					
					var theta = MathUtil.PI/12*(2*MathUtil.rnd() - 1.0);
					var v = 100*(MathUtil.rnd() - 0.5);
					c.q = new Vec2(0.0, 0.0);
					c.v = new Vec2(0.0, 0.0);
					b1.q = new Vec2(200*MathUtil.sin(theta), 200*MathUtil.cos(theta));
					b1.v = new Vec2( -v*MathUtil.cos(theta),   v*MathUtil.sin(theta));
					
					var next_state = [c.q.x/200, c.v.x/200, 2*MathUtil.atan((b1.q.y-c.q.y)/(b1.q.x-c.q.x))/MathUtil.PI, MathUtil.sqrt(b1.v*b1.v)/1000];
					this.state = {reward:0.0, next_state:next_state, initial:true, terminal:false};
				}
			}));
			
			//Gameを描画する
			this.renderer = return Channel.spawn(receiver -> Q.build({
				while(true) {
					var _ = return receiver.receive();
					ctx.render(stage);
				}
			}));
			
			return this.initializer.send(null);
			
			trace('game initialized.');
		});
	}
	
	@:access(rigid.dynamics.body.Body)
	private function drawBody(b:Body) {
		switch(b.shape.kind) {
			case ShapeKind.Sphere:
				var q = b.q;
				var r = cast(b.shape, SphereShape).radius;
				
				trace(q.x, q.y);
				g.fillColor = FillColor.Fill(Color.Hex(0xFFAAAA, 1.0));
				g.drawCircle(q.x, -q.y, r);
		}
	}
	
	private function drawAABB(b:Body) {
		var maxX = b.shape.aabb.max.x,
		    minX = b.shape.aabb.min.x,
		    maxY = b.shape.aabb.max.y,
		    minY = b.shape.aabb.min.y;
		
		g.fillColor = FillColor.None;
		g.lineColor = Color.Hex(0x000000, 1.0);
		g.drawRect(minX, -maxY, maxX - minX, maxY - minY);
	}
	
	private function drawContact(c:ContactConstraint) {
		var c1 = c.rq1 + c.p1.q, c2 = c.rq2 + c.p2.q;
		
		g.fillColor = FillColor.Fill(Color.Hex(0xFF0000, 1.0));
		g.drawCircle(c1.x, -c1.y, 2);
		g.drawCircle(c2.x, -c2.y, 2);
	}
	
	private function drawConstraint(c:Constraint) {
		var c1 = c.p1.q, c2 = c.p2.q;
		
		g.lineStyle(2.5, Color.Hex(0xFF0000, 1.0));
		g.moveTo(c1.x, -c1.y);
		g.lineTo(c2.x, -c2.y);
	}
}
