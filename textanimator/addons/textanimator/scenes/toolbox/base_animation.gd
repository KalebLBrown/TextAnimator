@tool
extends Button

var hovered : bool = false
var clicked : bool = false

func testing():
	var es : EditorSelection = EditorInterface.get_selection()
	var selected : Array[Node] = es.get_selected_nodes()
	
	if(selected.size() == 1):
		if(selected[0] is AnimatedText):
			
			var tag : String = $"../TagBox/TagEdit".text
			var start : int = int($"../CharacterBox/StartEdit".text)
			var end : int = int($"../CharacterBox/EndEdit".text)
			var time : float = float($"../TimeBox/TimeEdit".text)
			var delay: float = float($"../TimeBox/DelayEdit".text)
			
			# Set up all variables
			var proxy : AnimatedText = selected[0]
			var bbtag : ST_AnimatedTag = ST_AnimatedTag.new(tag, start, end)
			var action : A_BBCode = A_BBCode.new(time, delay, bbtag, proxy)
			var res : ActionFactory = action.GetActionFactory()
			
			# Add it to the list and notify the editor something's changed
			proxy.AddStartingAction(res)
			
			print("Added Animation")
	

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
	#print("hovered!")

func _on_mouse_exited():
	hovered = false
	#print("no longer hovered!")
