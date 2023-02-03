package test;
import js.Browser;
import pixi.core.display.DisplayObjectContainer;
import pixi.core.geom.point.ObservablePoint;
import pixi.core.geom.point.Point;
import pixi.core.graphics.Graphics;
import pixi.core.renderer.RenderOptions;
import pixi.core.renderer.Renderer;
import pixi.core.sprites.Sprite;
import pixi.core.texture.RenderTexture;
import pixi.core.texture.Texture;
import pixi.core.util.handler.RoleDispatcher;
import pixi.util.Color;
import pixi.util.Current;

/**
 * ...
 * @author leonaci
 */
class PixiDisplayTest
{
	static var WIDTH:Int = 2350;
	static var HEIGHT:Int = 1000;

	static public function main():Void {
		var option:RenderOptions = {
			autoResize: true,
			backgroundColor: 0xDDDDFF,
		};
		
		var renderer = new Renderer(WIDTH, HEIGHT, option);
		Browser.document.body.appendChild(renderer.view);
		
		function resize() {
			var aspectWidth = Browser.window.innerWidth / WIDTH;
			var aspectHeight = Browser.window.innerHeight / HEIGHT;
			var aspect = (aspectWidth > aspectHeight)? aspectHeight : aspectWidth;
			var canvas = renderer.view;
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
		
		var stage = new DisplayObjectContainer();
		var current = new Current();
		current.addFrameHandler(()->renderer.render(stage));
		
		var g:Graphics = new Graphics();
		g.lineStyle(1, Color.Hex(0x4e34c1, 0.8));
		g.beginFill(Color.Hex(0x13e25c, 0.5));
		g.drawRect(600, 200, 400, 500);
		g.drawRoundedRect(100, 100, 800, 800, 120);
		g.drawCircle(1300, 400, 300);
		g.drawEllipse(1800, 600, 500, 250);
		g.drawPolygon([new Point(530, 420), new Point(440, 640), new Point(500, 800), new Point(720, 830), new Point(920, 600), new Point(530, 420)]);
		stage.addChild(g);
		
		var rect = new Graphics();
		rect.x = WIDTH / 2;
		rect.y = HEIGHT / 2;
		stage.addChild(rect);
		
		rect.addFrameHandler(()->{
			rect.clear();
			rect.lineStyle(5, Color.Hex(0xFF0000, 1.0));
			rect.beginFill(Color.Hex(0xFFFF00, 0.5));
			
			rect.moveTo(-120 + Math.sin(0.1*current.frame) * 20, -100 + Math.cos(0.1*current.frame)* 20);
			rect.lineTo( 120 + Math.cos(0.1*current.frame) * 20, -100 + Math.sin(0.1*current.frame)* 20);
			rect.lineTo( 120 + Math.sin(0.1*current.frame) * 20,  100 + Math.cos(0.1*current.frame)* 20);
			rect.lineTo(-120 + Math.cos(0.1*current.frame) * 20,  100 + Math.sin(0.1*current.frame)* 20);
			rect.closePath();
			
			rect.rotation = current.frame * 0.01;
		});
		
		var test = new Sprite(Texture.fromImage('./test.png'));
		test.anchor.x = 0.5;
		test.anchor.y = 0.5;
		test.x = WIDTH / 2;
		test.y = HEIGHT / 2;
		stage.addChild(test);
		test.addFrameHandler(()->{test.rotation += -0.02;});
		
		current.run();
	}
	
}