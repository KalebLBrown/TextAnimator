@tool
class_name ST_AnimatedTag
extends Resource

@export var tag: String
@export var start: int
@export var end: int
@export var hasOptions: bool
@export var options: Array

func _init(_tag: String = "", _start: int = 0, _end: int = 1, _hasOptions: bool = false, _options: Array = Array()):
	tag = _tag
	start = _start
	end = _end
	hasOptions = _hasOptions
	options = _options

func GetStartTag() -> String:
	if(!hasOptions):
		return "[" + tag + "]"
	
	# Assemble the string to be returned
	var ret : String = "[" + tag
	
	for op in options:
		ret += op
	
	ret += "]"
	
	return ret

func GetEndTag() -> String:
	return "[/" + tag + "]"
