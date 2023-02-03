package pixi.util;

/**
 * ...
 * @author leonaci
 */
class PixiError {
	private var message:String;

	public function new(message:String) 
	{
		this.message = message;
	}
	
	public function toString():String return '[PixiError:$message]';
}