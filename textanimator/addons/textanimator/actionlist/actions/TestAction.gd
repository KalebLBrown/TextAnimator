class_name TestAction
extends Action

func _init(setTime: float, setDelay: float):
	timerMax = setTime
	timer = timerMax
	delay = setDelay

# Override for anything that needs to be initialised
func OnStart():
	print("Started")
	pass

# Override for anything that needs to be done on update
func TakeAction():
	print("Action Taken!")
	print("Time left = " + str(timer))
	pass

# Override for anything that needs to be cleaned up
func OnEnd():
	print("Ended")
	pass
