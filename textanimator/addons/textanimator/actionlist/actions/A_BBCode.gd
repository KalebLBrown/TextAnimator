class_name A_BBCode
extends Action

var _tag = ST_AnimatedTag

var _label: AnimatedText

func _init(setTime, setDelay, tag: ST_AnimatedTag, label: AnimatedText):
	timerMax = setTime
	timer = timerMax
	delay = setDelay
	
	_tag = tag
	_label = label

# Override for anything that needs to be initialised
func OnStart():
	_label.AddTag(_tag)
	pass

# Override for anything that needs to be done on update
func TakeAction():
	pass

# Override for anything that needs to be cleaned up
func OnEnd():
	_label.RemoveTag(_tag)
	pass
