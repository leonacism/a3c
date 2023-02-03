package chainer.reporter;

/**
 * ...
 * @author leonaci
 */
@:pythonImport('chainer.reporter', 'Reporter') extern class Reporter {
	/**
		Object to which observed values are reported.
		Reporter is used to collect values that users want to watch. The reporter
		object holds a mapping from value names to the actually observed values.
		We call this mapping `observations`.
		When a value is passed to the reporter, an object called `observer` can be
		optionally attached. In this case, the name of the observer is added as the
		prefix of the value name. The observer name should be registered
		beforehand.
		See the following example::
		   >>> from chainer import Reporter, report, report_scope
		   >>>
		   >>> reporter = Reporter()
		   >>> observer = object()  # it can be an arbitrary (reference) object
		   >>> reporter.add_observer('my_observer', observer)
		   >>> observation = {}
		   >>> with reporter.scope(observation):
		   ...     reporter.report({'x': 1}, observer)
		   ...
		   >>> observation
		   {'my_observer/x': 1}
		There are also a global API to add values::
		   >>> observation = {}
		   >>> with report_scope(observation):
		   ...     report({'x': 1}, observer)
		   ...
		   >>> observation
		   {'my_observer/x': 1}
		The most important application of Reporter is to report observed values
		from each link or chain in the training and validation procedures.
		:class:`~chainer.training.Trainer` and some extensions prepare their own
		Reporter object with the hierarchy of the target link registered as
		observers. We can use :func:`report` function inside any links and chains
		to report the observed values (e.g., training loss, accuracy, activation
		statistics, etc.).
		Attributes:
			observation: Dictionary of observed values.
	**/

	static public function __class__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Implement delattr(self, name).
	**/
	public function __delattr__(name:Dynamic):Dynamic;
	static public var __dict__ : Dynamic;
	/**
		__dir__() -> list
		default dir() implementation
	**/
	public function __dir__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	static public var __doc__ : Dynamic;
	/**
		Makes this reporter object current.
	**/
	public function __enter__() : Dynamic;
	/**
		Return self==value.
	**/
	public function __eq__(value:Dynamic) : Dynamic;
	/**
		Recovers the previous reporter object to the current.
	**/
	public function __exit__(exc_type:Dynamic, exc_value:Dynamic, traceback:Dynamic) : Dynamic;
	/**
		default object formatter
	**/
	public function __format__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return self>=value.
	**/
	public function __ge__(value:Dynamic):Dynamic;
	/**
		Return getattr(self, name).
	**/
	public function __getattribute__(name:Dynamic):Dynamic;
	/**
		Return self>value.
	**/
	public function __gt__(value:Dynamic):Dynamic;
	/**
		Return hash(self).
	**/
	public function __hash__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	@:native("__init__")
	public function ___init__() : Dynamic;
	public function __init_subclass__():Dynamic;
	/**
		Initialize self.  See help(type(self)) for accurate signature.
	**/
	public function new() : Void;
	/**
		Return self<=value.
	**/
	public function __le__(value:Dynamic):Dynamic;
	/**
		Return self<value.
	**/
	public function __lt__(value:Dynamic):Dynamic;
	static public var __module__ : Dynamic;
	/**
		Return self!=value.
	**/
	public function __ne__(value:Dynamic):Dynamic;
	/**
		Create and return a new object.  See help(type) for accurate signature.
	**/
	static public function __new__(?args:python.VarArgs<Dynamic>, ?kwargs:python.KwArgs<Dynamic>):Dynamic;
	/**
		helper for pickle
	**/
	public function __reduce__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		helper for pickle
	**/
	public function __reduce_ex__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return repr(self).
	**/
	public function __repr__():Dynamic;
	/**
		Implement setattr(self, name, value).
	**/
	public function __setattr__(name:Dynamic, value:Dynamic):Dynamic;
	/**
		__sizeof__() -> int
		size of object in memory, in bytes
	**/
	public function __sizeof__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		Return str(self).
	**/
	public function __str__():Dynamic;
	/**
		Abstract classes can override this to customize issubclass().
		
		This is invoked early on by abc.ABCMeta.__subclasscheck__().
		It should return True, False or NotImplemented.  If it returns
		NotImplemented, the normal algorithm is used.  Otherwise, it
		overrides the normal algorithm (and the outcome is cached).
	**/
	static public function __subclasshook__(args:haxe.extern.Rest<Dynamic>):Dynamic;
	/**
		list of weak references to the object (if defined)
	**/
	public var __weakref__ : Dynamic;
	/**
		Registers an observer of values.
        Observer defines a scope of names for observed values. Values observed
        with the observer are registered with names prefixed by the observer
        name.
        Args:
            name (str): Name of the observer.
            observer: The observer object. Note that the reporter distinguishes
                the observers by their object ids (i.e., ``id(owner)``), rather
                than the object equality.
	**/
	public function add_observer(name:Dynamic, observer:Dynamic) : Dynamic;
	/**
		Registers multiple observers at once.
        This is a convenient method to register multiple objects at once.
        Args:
            prefix (str): Prefix of each name of observers.
            observers: Iterator of name and observer pairs.
	**/
	public function add_observers(prefix:Dynamic, observers:Dynamic) : Dynamic;
	/**
		Reports observed values.
        The values are written with the key, prefixed by the name of the
        observer object if given.
        .. note::
           As of v2.0.0, if a value is of type :class:`~chainer.Variable`, the
           variable is copied without preserving the computational graph and
           the new variable object purged from the graph is stored to the
           observer. This behavior can be changed by setting
           ``chainer.config.keep_graph_on_report`` to ``True``.
        Args:
            values (dict): Dictionary of observed values.
            observer: Observer object. Its object ID is used to retrieve the
                observer name, which is used as the prefix of the registration
                name of the observed value.
	**/
	public function report(values:Dynamic, ?observer:Dynamic) : Dynamic;
	/*
		Creates a scope to report observed values to ``observation``.
        This is a context manager to be passed to ``with`` statements. In this
        scope, the observation dictionary is changed to the given one.
        It also makes this reporter object current.
        Args:
            observation (dict): Observation dictionary. All observations
                reported inside of the ``with`` statement are written to this
                dictionary.
	**/
	public function scope(observation:Dynamic) : Dynamic;
}