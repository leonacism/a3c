package util.js;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import rigid.common.MathUtil;

/**
 * ...
 * @author leo
 */
class GraphicsJS extends Graphics {
	private var canvas:CanvasElement;
	private var g2:CanvasRenderingContext2D;
	
	public inline function new(canvas:CanvasElement) {
		this.canvas = canvas;
		this.g2 = canvas.getContext2d();
		
		this.WIDTH = canvas.width; this.HEIGHT = canvas.height;
	}
	
	override public function background(r:Int, g:Int, b:Int) {
		g2.fillStyle = getColor(r, g, b);
		g2.fillRect(0, 0, canvas.width, canvas.height);
	}
	
	override public function color(r:Int, g:Int, b:Int) {
		g2.fillStyle = getColor(r, g, b);
		g2.strokeStyle = getColor(r, g, b);
	}
	
	override public function point(x:Float, y:Float, size:Float) {
		g2.beginPath();
		g2.arc(x+WIDTH/2, -y+HEIGHT/2, size / 2, 0, 2 * MathUtil.PI, false);
		g2.fill();
		g2.stroke();
	}
	
	override public function line(x1:Float, y1:Float, x2:Float, y2:Float) {
		g2.beginPath();
		g2.lineTo(x1+WIDTH/2, -y1+HEIGHT/2);
		g2.lineTo(x2+WIDTH/2, -y2+HEIGHT/2);
		g2.stroke();
	}
	
	override public function arc(x:Float, y:Float, r:Float) {
		g2.beginPath();
		g2.arc(x+WIDTH/2, -y+HEIGHT/2, r, 0, 2 * MathUtil.PI, false);
		g2.fill();
		g2.stroke();
	}
	
	override public function text(str:String, x:Float, y:Float, size:Int) {
		g2.strokeText(str, x+WIDTH/2, -y+HEIGHT/2, str.length*size);
	}
	
	override public function setSize(size:Float) {
		g2.lineWidth = size;
	}
	
	function getColor(r:Int, g:Int, b:Int, ?a:Int = 255) return 'rgba(${r}, ${g}, ${b}, ${a/255})';
	
}