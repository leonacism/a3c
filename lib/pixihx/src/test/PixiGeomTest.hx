package test;
import pixi.core.geom.transform.Transform;
import pixi.core.geom.Affine;
import pixi.core.geom.point.Point;

/**
 * ...
 * @author leonaci
 */
class PixiGeomTest {
	
	static public function main():Void {
		var p = new Point(2, 3);
		var q = new Point(2, 3);
		trace(p != q);
		q.x = 4; q.y = 5;
		trace(p != q);
		
		var mat = Affine.fromArray([
			2, 3, 4,
			5, 6, 7,
		]);
		
		trace(Std.string(mat * q));
		
		var transform = new Transform();
		transform.setFromMatrix(mat);
		trace('skew:${transform.skew}');
		trace('scale:${transform.scale}');
	}
	
}