package pixi.core.util.handler;
import haxe.EnumTools;
import haxe.EnumTools.EnumValueTools;
import pixi.util.PixiError;

/**
 * ...
 * @author leonaci
 */
class RoleDispatcher<Role:EnumValue>
{
	private var roleMap:Map<String, GenericDispatcher<Void->Void>>;

	public function new() 
	{
		roleMap = new Map();
	}
	
	public function add(role:Role, handler:Void->Void, once:Bool):Void {
		var roleName:String = Type.enumConstructor(role);
		if (!roleMap.exists(roleName)) roleMap[roleName] = new GenericDispatcher(ConsumerPreset.IN_ORDER);
		roleMap[roleName].add(handler, once);
	}
	
	public function remove(role:Role, handler:Void->Void):Void {
		var roleName:String = Type.enumConstructor(role);
		roleMap[roleName].remove(handler);
	}
	
	public function execute(role:Role):Void {
		var roleName:String = Type.enumConstructor(role);
		if (!roleMap.exists(roleName)) throw new PixiError('対応していないEnumが呼び出されました');
		roleMap[roleName].execute(h->h());
	}
	
	public function exists(role:Role):Bool {
		var roleName:String = Type.enumConstructor(role);
		return roleMap.exists(roleName);
	}
	
	public function clear(role:Role):Bool {
		var roleName:String = Type.enumConstructor(role);
		return roleMap.remove(roleName);
	}
	
	public function count(role:Role):Int {
		var roleName:String = Type.enumConstructor(role);
		return roleMap[roleName].length;
	}
}