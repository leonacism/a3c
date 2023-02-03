package pixi.core.geom.shape;
import pixi.core.graphics.GraphicsData;
import pixi.core.graphics.WebGLGraphicsData;
import pixi.util.Color;
import pixi.util.MathUtil;

using Lambda;

/**
 * ...
 * @author leonaci
 */
class PolyLine
{
	private var points:Array<Float>;

	public function new(points:Array<Float>) {
		this.points = points;
	}
	
	public function build(data:GraphicsData, webglData:WebGLGraphicsData):Void {
		if (data.nativeLines || data.lineWidth == 0) buildNativeLine(data, webglData);
		else buildLine(data, webglData);
	}
	
	private function buildLine(data:GraphicsData, webglData:WebGLGraphicsData):Void {
		var vertices = webglData.vertices;
		var indices = webglData.indices;
		
		var indexStart = Std.int(vertices.length / 6);
		
		var closed = points[0] == points[points.length - 2] && points[1] == points[points.length - 1];
		
		var width = data.lineWidth / 2;
		
		var a = data.lineColor.a;
		var r = data.lineColor.r * a;
		var g = data.lineColor.g * a;
		var b = data.lineColor.b * a;
		
		var p1x = 0.0;
		var p1y = 0.0;
		var p2x = 0.0;
		var p2y = 0.0;
		var p3x = 0.0;
		var p3y = 0.0;
		
		var perp1x = 0.0;
		var perp1y = 0.0;
		var perp2x = 0.0;
		var perp2y = 0.0;
		var perp3x = 0.0;
		var perp3y = 0.0;
		
		if (!closed) {
			p2x = points[0];
			p2y = points[1];
			p3x = points[2];
			p3y = points[3];
			
			perp2x = -(p2y - p3y);
			perp2y =   p2x - p3x ;
			
			var dist = MathUtil.sqrt(perp2x * perp2x + perp2y * perp2y);
			perp2x /= dist;
			perp2y /= dist;
			perp2x *= width;
			perp2y *= width;
			
			[
				p2x - perp2x, p2y - perp2y, r, g, b, a,
				p2x + perp2x, p2y + perp2y, r, g, b, a,
			].iter(e-> vertices.push(e));
		}
		else {
			points.unshift(points[points.length - 3]);
			points.unshift(points[points.length - 4]);
		}
		
		var length = Std.int(points.length / 2);
		var indexCount = points.length;
		
		for (i in 1...length-1) {
			p1x = points[(i - 1) * 2    ];
			p1y = points[(i - 1) * 2 + 1];
			p2x = points[ i      * 2    ];
			p2y = points[ i      * 2 + 1];
			p3x = points[(i + 1) * 2    ];
			p3y = points[(i + 1) * 2 + 1];
			
			perp1x = -(p1y - p2y);
			perp1y =   p1x - p2x ;
			
			var dist = MathUtil.sqrt(perp1x * perp1x + perp1y * perp1y);
			perp1x /= dist;
			perp1y /= dist;
			perp1x *= width;
			perp1y *= width;
			
			perp2x = -(p2y - p3y);
			perp2y =   p2x - p3x ;
			
			dist = MathUtil.sqrt(perp2x * perp2x + perp2y * perp2y);
			perp2x /= dist;
			perp2y /= dist;
			perp2x *= width;
			perp2y *= width;
			
			var ax = (-perp1y + p1y) - (-perp1y + p2y);
			var ay = (-perp1x + p2x) - (-perp1x + p1x);
			var bx = (-perp2y + p3y) - (-perp2y + p2y);
			var by = (-perp2x + p2x) - (-perp2x + p3x);
			var c1 = (-perp1x + p1x) * (-perp1y + p2y) - (-perp1x + p2x) * (-perp1y + p1y);
			var c2 = (-perp2x + p3x) * (-perp2y + p2y) - (-perp2x + p2x) * (-perp2y + p3y);
			
			var denom = ax * by - bx * ay;
			if (MathUtil.abs(denom) < 0.1) {
				[
					p2x - perp1x, p2y - perp1y, r, g, b, a,
					p2x + perp1x, p2y + perp1y, r, g, b, a,
				].iter(e->vertices.push(e));
				
				continue;
			}
			
			var px = (ay * c2 - by * c1) / denom;
			var py = (bx * c1 - ax * c2) / denom;
			var vpx = p2x - px;
			var vpy = p2y - py;
			var pdist = (px - p2x) * (px - p2x) + (py - p2y) * (py - p2y);
			
			if (pdist > (196 * width * width)) {
				perp3x = perp1x - perp2x;
				perp3y = perp1y - perp2y;
				
				dist = MathUtil.sqrt(perp3x * perp3x + perp3y * perp3y);
				perp3x /= dist;
				perp3y /= dist;
				perp3x *= width;
				perp3y *= width;
				
				[
					p2x - perp3x, p2y - perp3y, r, g, b, a,
					p2x + perp3x, p2y + perp3y, r, g, b, a,
					p2x - perp3x, p2y - perp3y, r, g, b, a,
				].iter(e->vertices.push(e));
				
				indexCount++;
			}
			else {
				[
					p2x - vpx, p2y - vpy, r, g, b, a,
					p2x + vpx, p2y + vpy, r, g, b, a,
				].iter(e->vertices.push(e));
			}
		}
		
		if (!closed) {
			p1x = points[(length - 2) * 2    ];
			p1y = points[(length - 2) * 2 + 1];
			p2x = points[(length - 1) * 2    ];
			p2y = points[(length - 1) * 2 + 1];
			
			perp1x = -(p1y - p2y);
			perp1y =   p1x - p2x ;
			
			var dist = MathUtil.sqrt(perp1x * perp1x + perp1y * perp1y);
			perp1x /= dist;
			perp1y /= dist;
			perp1x *= width;
			perp1y *= width;
			
			[
				p2x - perp1x, p2y - perp1y, r, g, b, a,
				p2x + perp1x, p2y + perp1y, r, g, b, a,
			].iter(e-> vertices.push(e));
			
			indices.push(indexStart);
			indices.push(indexStart);
			
			for (i in 1...indexCount - 1) indices.push(indexStart + i);
			
			indices.push(indexStart + indexCount - 1);
			indices.push(indexStart + indexCount - 1);
		}
		else {
			indices.push(indexStart);
			indices.push(indexStart);
			
			for (i in 1...indexCount - 4) indices.push(indexStart + i);
			
			indices.push(indexStart);
			indices.push(indexStart + 1);
			indices.push(indexStart + 1);
			
			points.shift();
			points.shift();
		}
	}
	
	
	inline private function buildNativeLine(data:GraphicsData, webglData:WebGLGraphicsData):Void {
		if (points.length == 0 ) return;
		
		var a = data.lineColor.a;
		var r = data.lineColor.r * a;
		var g = data.lineColor.g * a;
		var b = data.lineColor.b * a;
		
		for(i in 1...Std.int(points.length / 2)) {
			var p1x = points[(i - 1) * 2    ];
			var p1y = points[(i - 1) * 2 + 1];
			var p2x = points[ i      * 2    ];
			var p2y = points[ i      * 2 + 1];
			
			[
				p1x, p1y, r, g, b, a,
				p2x, p2y, r, g, b, a,
			].iter(e->webglData.vertices.push(e));
		}
	}
}