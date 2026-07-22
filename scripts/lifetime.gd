extends Node
class_name LifeTime

signal time_ran_out();

func _ready():
	print(is_processing())

@export var startTime := 10.0;
var currentTime := startTime:
	set(newTime):
		if newTime <= 0.0:
			time_ran_out.emit();
			stop();
		currentTime = max(0.0, newTime);

var timeMultiplier := 1.0;
var active := true;

static func create(_startTime) -> LifeTime:
	var lifetime = LifeTime.new();
	lifetime.startTime = _startTime;
	lifetime.currentTime = _startTime;
	lifetime.start();
	return lifetime;

func stop():
	active = false;

func start():
	active = true;

func reset():
	stop();
	currentTime = startTime;
	
func restart():
	reset();
	start();

func _process(delta):
	if (active):
		currentTime -= delta * timeMultiplier;
