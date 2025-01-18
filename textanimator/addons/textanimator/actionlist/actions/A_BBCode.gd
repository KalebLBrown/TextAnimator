class_name A_BBCode
extends Action

func _init(setTime, setDelay):
	timerMax = setTime
	timer = timerMax
	delay = setDelay

# Override for anything that needs to be initialised
func OnStart():
	pass

# Override for anything that needs to be done on update
func TakeAction():
	pass

# Override for anything that needs to be cleaned up
func OnEnd():
	pass
