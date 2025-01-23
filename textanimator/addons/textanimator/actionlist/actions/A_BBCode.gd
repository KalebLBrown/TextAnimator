class_name A_BBCode
extends Action

var _text: String

var _label: AnimatedText

func _init(setTime, setDelay, text: String, label: AnimatedText):
	timerMax = setTime
	timer = timerMax
	delay = setDelay
	
	_text = text
	_label = label

# Override for anything that needs to be initialised
func OnStart():
	_label.ChangeText(_text)
	pass

# Override for anything that needs to be done on update
func TakeAction():
	pass

# Override for anything that needs to be cleaned up
func OnEnd():
	pass
