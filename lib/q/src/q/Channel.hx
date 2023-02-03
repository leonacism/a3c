package q;
import q.Q.Cont;
import q.Box;

/**
 * ...
 * @author leonaci
 */
typedef Sender<T> = {send:T->Cont<Dynamic>};
typedef Receiver<T> = {receive:Void->Cont<Dynamic>};

class Channel {
	static public function spawn<T>(handler:Receiver<T>->Cont<Dynamic>):Cont<Sender<T>> {
		var ch = new Box<T>();
		var receiver = {receive:()->ch.take()}
		var sender = {send:x->Q.fork(ch.put(x))};
		
		return Q.build({
			return Q.fork(handler(receiver));
			return Q.pure(sender);
		});
	}
}