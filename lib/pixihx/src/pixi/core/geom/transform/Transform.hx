package pixi.core.geom.transform;
import pixi.core.geom.Affine;
import pixi.core.geom.point.Point;
import pixi.core.geom.point.ObservablePoint;
import pixi.util.MathUtil;

/**
 * ...
 * @author leonaci
 */
class Transform implements ITransform {
	static public var IDENTITY(get, never):Transform;
	inline static function get_IDENTITY() return new Transform();
	
	public var position(default, null):Point;
	
	/**
	 * the scaling paramters fot the x direction(scale.x) and the y direction(scale.y)
	 * | scale.x    0    |
	 * |    0    scale.y |
	 */
	public var scale(default, null):Point;
	
	/**
	 * the shearing parameters for x direction(skew.y) and y direction(skew.x)
	 * 
	 * |      1      tan(skew.y) |
	 * | tan(skew.x)      1      |
	 * 
	 * the x-unit vector transforms to the vector that has the slope tan(skew.x) on x-y plane.
	 * the y-unit vector transforms to the vector that has the slope tan(pi/2 - skew.y) on x-y plane.
	 */
	public var skew(default, null):ObservablePoint;
	
	/**
	 * the local coordinate of the object. rotation and shear transformations are performed around this point.
	 */
	public var pivot(default, null):Point;
	
	/**
	 * the rotation parameter on x-y plane.
	 * 
	 * | cos(rot) -sin(rot) |
	 * | sin(rot)  cos(rot) |
	 */
	public var rotation(default, set):Float;
	function set_rotation(rotation:Float):Float {
		this.rotation = rotation;
		onUpdateSkew();
		return this.rotation;
	}
	
	public var global(default, null):Affine;
	public var local(default, null):Affine;
	
	public var globalDirty:Bool;
	
	/**
	 *  the matrix parameters that mix rotation and shear transformation.
	 * 
	 *  | cx cy |
	 *  | sx sy |
	 */
	private var cx:Float;
	private var sx:Float;
	private var cy:Float;
	private var sy:Float;
	
	public function new() {
		position = new Point(0, 0);
		scale = new Point(1, 1);
		skew = new ObservablePoint(onUpdateSkew, 0, 0);
		pivot = new Point(0, 0);
		rotation = 0;
		
		global = new Affine();
		local = new Affine();
		
		globalDirty = false;
		
		cx = 1; sx = 0;
		cy = 0; sy = 1;
	}
	
	/**
	 * 
	 *  | cx cy | = | cos(rot) -sin(rot) ||      1      tan(skew.y) |
	 *  | sx sy |   | sin(rot)  cos(rot) || tan(skew.x)      1      |
	 * 
	 *            = | cos(rot) -sin(rot) || cos(skew.x) sin(skew.y) || 1/cos(skew.x)       0       |
	 *              | sin(rot)  cos(rot) || sin(skew.x) cos(skew.y) ||       0       1/cos(skew.y) |
	 * 
	 *            = | cos(rot + skew.x) -sin(rot - skew.y) || 1/cos(skew.x)       0       |
	 *              | sin(rot + skew.x)  cos(rot - skew.y) ||       0       1/cos(skew.y) |
	 * 
	 */
	inline function onUpdateSkew():Void {
		cx = MathUtil.cos(rotation + skew.x) / MathUtil.cos(skew.x);
		sx = MathUtil.sin(rotation + skew.x) / MathUtil.cos(skew.x);
		cy = MathUtil.cos(rotation + MathUtil.PI/2 - skew.y) / MathUtil.cos(skew.y);
		sy = MathUtil.sin(rotation + MathUtil.PI/2 - skew.y) / MathUtil.cos(skew.y);
	}
	
	/**
	 * 
	 * local:
	 * 
	 * | a  b  X - (ax + by) |   | 1  0  X || a  b  0 || 1  0 -x |
	 * | c  d  Y - (cx + dy) | = | 0  1  Y || c  d  0 || 0  1 -y |
	 * | 0  0       1        |   | 0  0  1 || 0  0  1 || 0  0  1 |
	 * 
	 */
	public inline function updateLocalTransform():Void {
		var l = local;
		
		l.a = cx * scale.x; l.b = cy * scale.y; l.tx = position.x - (l.a * pivot.x + l.b * pivot.y);
		l.c = sx * scale.x; l.d = sy * scale.y; l.ty = position.y - (l.c * pivot.x + l.d * pivot.y);
	}
	
	/**
	 * 
	 * global:
	 * 
	 * | a  b  tx || A  B  TX |
	 * | c  d  ty || C  D  TY |
	 * | 0  0   1 || 0  0   1 |
	 * 
	 */
	public inline function updateGlobalTransform(parent:ITransform):Void {
		var l = local, g = global, p = parent.global;
		
		l.a = cx * scale.x; l.b = cy * scale.y; l.tx = position.x - (l.a * pivot.x + l.b * pivot.y);
		l.c = sx * scale.x; l.d = sy * scale.y; l.ty = position.y - (l.c * pivot.x + l.d * pivot.y);
		
		g.a = l.a * p.a + l.b * p.c; g.b = l.a * p.b + l.b * p.d; g.tx = l.a * p.tx + l.b * p.ty + l.tx;
		g.c = l.c * p.a + l.d * p.c; g.d = l.c * p.b + l.d * p.d; g.ty = l.c * p.tx + l.d * p.ty + l.ty;
		
		globalDirty = true;
	}
	
	public inline function setFromMatrix(mat:Affine):Void {
		mat.decompose(this);
	}
}