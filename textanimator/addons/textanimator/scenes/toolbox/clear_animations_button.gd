@tool
extends Button


func _on_button_down():
	var es : EditorSelection = EditorInterface.get_selection()
	var selected : Array[Node] = es.get_selected_nodes()
	
	if(selected.size() == 1):
		if(selected[0] is AnimatedText):
			var proxy : AnimatedText = selected[0]
			proxy.ClearStartingActions()
			
			print("Cleared actions")
