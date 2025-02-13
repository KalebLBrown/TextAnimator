class_name A_BBCode
extends Action

var _tag : ST_AnimatedTag

var _label : AnimatedText

func _init(setTime : float, setDelay : float, tag: ST_AnimatedTag, label: AnimatedText):
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

# Override this function to enable savable actions
func GetActionFactory() -> ActionFactory:
	var res : ActionFactory = ActionFactory.new()
	res.ActionScript = self.get_script()
	
	res.Parameters.append(timerMax)
	res.Parameters.append(delay)
	res.Parameters.append(_tag)
	res.Parameters.append(_label)
	
	return res

static func MakeFromFactory(factory: ActionFactory) -> A_BBCode:
	var act: A_BBCode = A_BBCode.new(factory.Parameters[0], factory.Parameters[1], factory.Parameters[2], factory.Parameters[3])
	return act
