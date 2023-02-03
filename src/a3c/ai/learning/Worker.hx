package a3c.ai.learning;

/**
 * @author leonaci
 */
interface Worker 
{
	function value(input:Dynamic):Dynamic;
	function serialize():Void;
	function copyParams(source:Worker):Void;
	function updateGrads(observations:Array<Dynamic>, target:Worker):Void;
}