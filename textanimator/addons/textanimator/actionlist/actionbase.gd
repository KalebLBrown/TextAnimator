# This is a base action class that can be overwritten
# There are three functions that are made to be overridden

class_name Action

# Base variables

enum InterpolationType 
{
	linear,
	easein,
	easeout,
	easeinout
}

var easing: InterpolationType = InterpolationType.linear

var _started: bool = false

var timeSensitive: bool = true # determines whether an action has a timer/delay on it

var destroyed: bool = false

var delay: float = 0.0

var timer: float = 0.0

var timerMax: float = 0.0

var updating: bool = true

var blocking: Array[String] = []

var blockedBy: Array[String] = []

var object: Node 

# End of variables

# Constructor
# NOTE: Only one constructor is allowed per class
# Constructors can be overridden by child classes, however
func _init(setTimer: float):
	timerMax = setTimer
	timer = timerMax

# Handles how the action updates, makes sure it updates correctly
func UpdateAction(dt: float):
	# Downtick the delay
	if(delay > 0.0 && timeSensitive):
		delay -= dt
		return false
	
	# If the action hasn't been started, start it
	if(!_started):
		OnStart()
		_started = true
	
	# Take the action
	TakeAction()
	
	# Downtick the timer and see if the action is finished
	timer -= dt
	if(timer < 0.0 && timeSensitive):
		OnEnd()
		return true
	
	return false

# Override for anything that needs to be initialised
func OnStart():
	pass

# Override for anything that needs to be done on update
func TakeAction():
	pass

# Override for anything that needs to be cleaned up
func OnEnd():
	pass

func CalcInterpolation():
	var lerp: float = (timerMax - timer) / timerMax
	
	match(easing):
		InterpolationType.linear:
			return lerp
		InterpolationType.easein:
			return 1.0 - cos(lerp * PI / 2.0)
		InterpolationType.easeout:
			return sin(lerp * PI / 2.0)
		InterpolationType.easeinout:
			return -(cos(PI * lerp) - 1.0) / 2.0
		_:
			return 0.0
