package a3c.ai.learning.local;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('update_grads') extern class UpdateGradsModule
{
	static function update_grads(target:LocalWorker, source:LocalWorker, episode:Dynamic):Void;
}