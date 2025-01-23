class_name ST_AnimatedTag
extends RefCounted

var tag: String
var start: int
var end: int
var hasOptions: bool
var options: Array

func _init(_tag: String, _start: int, _end: int, _hasOptions: bool = false, _options: Array = Array()):
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
