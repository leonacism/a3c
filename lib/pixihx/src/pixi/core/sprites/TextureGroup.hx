package pixi.core.sprites;
import pixi.core.texture.Texture;
import pixi.util.BlendMode;

/**
 * @author leonaci
 */
typedef TextureGroup =
{
	var textures:Array<Texture>;
	var ids:Array<Int>;
	var size:Int;
	var start:Int;
	var blendMode:BlendMode;
}