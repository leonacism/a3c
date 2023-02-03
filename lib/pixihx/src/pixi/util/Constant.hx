package pixi.util;

/**
 * ...
 * @author leonaci
 */
class Constant {
	static public var DATA_URI:EReg = ~/^\s*data:(?:([\w-]+)\/([\w+.-]+))?(?:;(charset=[\w-]+|base64))?,(.*)/i;
	static public var URL_FILE_EXT:EReg = ~/\.(\w{3,4})(?:$|\?|#)/i;
	static public var RETINA_PREFIX:EReg = ~/@([0-9\.]+)x/;
}

enum ScaleMode {
	Linear;
	Nearest;
}

enum ShapeKind {
	Rectangle;
	RoundedRectangle;
	Circle;
	Polygon;
	Ellipse;
}