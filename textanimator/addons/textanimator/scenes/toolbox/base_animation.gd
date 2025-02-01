@tool
extends Button

var hovered : bool = false
var clicked : bool = false

func _doOnClicked(event: InputEventMouseButton):
	# If left click up
	if(event.button_index == 1 && !event.pressed):
		clicked = false
	
	# Check if the label is hovered
	if(hovered == false):
		return
	
	# If left click down
	if(event.button_index == 1 && event.pressed):
		clicked = true


func _doOnDragged(event: InputEventMouseMotion):
	if(clicked):
		print("dragging!")

func _input(event):
	match(event.get_class()):
		"InputEventMouseButton":
			_doOnClicked(event)
		"InputEventMouseMotion":
			_doOnDragged(event)
	

func _on_mouse_entered():
	hovered = true
	print("hovered!")


func _on_mouse_exited():
	hovered = false
	print("no longer hovered!")
