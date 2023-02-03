package pixi.accessibility;
import js.html.HtmlElement;

/**
 * ...
 * @author leonaci
 */
@:structInit class AccessibleTarget
{
	public var accessible:Bool;
	public var accessibleTitle:String;
	public var accessibleHint:String;
	public var tabIndex:Int;
	public var accessibleActive:Bool;
	public var accessibleDiv:HtmlElement;
	public var renderId:Int;
	
	inline function new(
		?accessible = false,
		?accessibleTitle = null,
		?accessibleHint = null,
		?tabIndex = 0,
		?accessibleActive = false,
		?accessibleDiv = null,
		?renderId = -1
	)
	{
		this.accessible = accessible;
		this.accessibleTitle = accessibleTitle;
		this.accessibleHint = accessibleHint;
		this.tabIndex = tabIndex;
		this.accessibleActive = accessibleActive;
		this.accessibleDiv = accessibleDiv;
		this.renderId = renderId;
	}
}