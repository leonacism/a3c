package pixi.core.geom;
import pixi.core.geom.point.Point;
import pixi.core.geom.transform.ITransform;
import pixi.util.MathUtil;
import pixi.util.PixiError;

/**
 * the 2-dimention motion matrix:
 * | a b tx ||x|   | ax + by + tx |
 * | c d ty ||y| = | cx + dy + ty |
 * | 0 0  1 ||1|   |       1      |
 * @author leonaci
 */
abstract Affine({a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float}) {
	public var a(get, set):Float;
	inline function get_a():Float return this.a;
	inline function set_a(a:Float):Float return this.a = a;
	
	public var b(get, set):Float;
	inline function get_b():Float return this.b;
	inline function set_b(b:Float):Float return this.b = b;
	
	public var c(get, set):Float;
	inline function get_c():Float return this.c;
	inline function set_c(c:Float):Float return this.c = c;
	
	public var d(get, set):Float;
	inline function get_d():Float return this.d;
	inline function set_d(d:Float):Float return this.d = d;
	
	public var tx(get, set):Float;
	inline function get_tx():Float return this.tx;
	inline function set_tx(tx:Float):Float return this.tx = tx;
	
	public var ty(get, set):Float;
	inline function get_ty():Float return this.ty;
	inline function set_ty(ty:Float):Float return this.ty = ty;
	
	inline public function new(?a:Float=1, ?b:Float=0, ?c:Float=0, ?d:Float=1, ?tx:Float=0, ?ty:Float=0) {
		this = {a:a, b:b, c:c, d:d, tx:tx, ty:ty};
	}
	
	static inline public function fromArray(arr:Array<Float>):Affine {
		if(arr.length < 6) throw new PixiError('the array\'s length should be 6.');
		var mat = new Affine();
		mat.a = arr[0]; mat.b = arr[1]; mat.tx = arr[2];
		mat.c = arr[3]; mat.d = arr[4]; mat.ty = arr[5];
		return mat;
	}
	
	inline public function set(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float):Affine {
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
		this.tx = tx;
		this.ty = ty;
		
		return cast this;
	}
	
	inline public function toArray(?transpose:Bool=false):Array<Float> {
		var array = [];
		
		if (transpose) {
			array[0] = this.a; array[3] = this.b; array[6] = this.tx; 
			array[1] = this.c; array[4] = this.d; array[7] = this.ty; 
			array[2] =      0; array[5] =      0; array[8] =       1; 
		}
		else {
			array[0] = this.a; array[1] = this.b; array[2] = this.tx; 
			array[3] = this.c; array[4] = this.d; array[5] = this.ty; 
			array[6] =      0; array[7] =      0; array[8] =       1;
		}
		
		return array;
	}
	
	@:op(A*B)
	static inline public function append(m:Affine, n:Affine):Affine {
		var mat = new Affine();
		
		mat.a = m.a * n.a + m.b * n.c; mat.b = m.a * n.b + m.b * n.d; mat.tx = m.a * n.tx + m.b * n.ty + m.tx;
		mat.c = m.c * n.a + m.d * n.c; mat.d = m.c * n.b + m.d * n.d; mat.ty = m.c * n.tx + m.d * n.ty + m.ty;
		
		return mat;
	}
	
	@:op(A*B)
	static inline public function apply(mat:Affine, pos:Point):Point {
		var newPos = new Point();
		
		newPos.x = mat.a * pos.x + mat.b * pos.y + mat.tx;
		newPos.y = mat.c * pos.x + mat.d * pos.y + mat.ty;
		
		return newPos;
	}
	
	@:op(~A)
	static inline public function inverse(mat:Affine):Affine {
		var newMat = new Affine();
		
		var invdet = 1 / (mat.a * mat.d - mat.b * mat.c);
		
		newMat.a =   invdet * mat.d; newMat.b = - invdet * mat.b; newMat.tx = - invdet * (mat.d * mat.tx - mat.b * mat.ty);
		newMat.c = - invdet * mat.c; newMat.d =   invdet * mat.a; newMat.ty =   invdet * (mat.c * mat.tx - mat.a * mat.ty);
		
		return newMat;
	}
	
	public function decompose(transform:ITransform):ITransform {
		var skewX =  MathUtil.atan2( c, a);
		var skewY = -MathUtil.atan2(-b, d);
		
		var delta = Math.abs(skewX + skewY);
		if (delta < 1e-5) {
			transform.rotation = skewX;
			
			if(a < 0 && d >= 0) {
				transform.rotation += (transform.rotation <= 0)? MathUtil.PI : - MathUtil.PI;
			}
			
			transform.skew.x = 0;
			transform.skew.y = 0;
		}
		else {
			transform.skew.x = skewX;
			transform.skew.y = skewY;
		}
		
		transform.scale.x = MathUtil.sqrt(a * a + c * c);
		transform.scale.y = MathUtil.sqrt(b * b + d * d);
		
		transform.position.x = this.tx;
		transform.position.y = this.ty;
		
		return transform;
	}
	
	public function identity():Affine {
		this.a = 1.0;
		this.b = 0.0;
		this.c = 0.0;
		this.d = 1.0;
		this.tx = 0.0;
		this.ty = 0.0;
		
		return cast this;
	}
}