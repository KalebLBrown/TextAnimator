@tool
extends Button

var hovered : bool = false
var clicked : bool = false

func testing():
	var es : EditorSelection = EditorInterface.get_selection()
	var selected : Array[Node] = es.get_selected_nodes()
	
	if(selected.size() == 1):
		if(selected[0] is AnimatedText):
			print("selected text!")
			var proxy : AnimatedText = selected[0]
			var bbtag : ST_AnimatedTag = ST_AnimatedTag.new("b", 0, 3)
			var action : A_BBCode = A_BBCode.new(3.0, 4.0, bbtag, proxy)
			print(proxy.get_property_list())
			proxy.startingActions.append(action)
	

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
		testing()


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
