package pixi.core.geom.transform;
import pixi.core.geom.Affine;
import pixi.core.geom.point.Point;
import pixi.core.geom.point.ObservablePoint;

/**
 * ...
 * @author leonaci
 */
interface ITransform {
	var position(default, null):Point;
	var scale(default, null):Point;
	var skew(default, null):ObservablePoint;
	var pivot(default, null):Point;
	var rotation(default, set):Float;
	
	var global(default, null):Affine;
	var local(default, null):Affine;
	
	var globalDirty:Bool;
	
	function updateLocalTransform():Void;
	
	function updateGlobalTransform(parent:ITransform):Void;
	
	function setFromMatrix(mat:Affine):Void;
}