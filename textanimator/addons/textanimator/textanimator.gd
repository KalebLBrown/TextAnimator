@tool
extends EditorPlugin


const editorAddon = preload("res://addons/textanimator/scenes/TextAnimatorTool.tscn")

var dockedScene

func _enter_tree():
	dockedScene = editorAddon.instantiate()
	add_control_to_dock(DOCK_SLOT_LEFT_BL, dockedScene)
	pass


func _exit_tree():
	remove_control_from_docks(dockedScene)
	dockedScene.free()
	pass
