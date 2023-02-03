package pixi.core.util.handler;

/**
 * 型Tの実行関数のラッパークラス
 * @author leonaci
 */
@:callable abstract Handler<T>(T) from T {
	public function new(f:T) {
		this = f;
	}
}