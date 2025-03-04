@tool
extends EditorPlugin

# For toolbox
const toolboxScene = preload("res://addons/textanimator/scenes/TextAnimatorToolbox.tscn")
var toolboxInstance

#  For Animation interface
const animatorScene = preload("res://addons/textanimator/scenes/TextAnimatorAnimationViewer.tscn")
var animatorInstance


func _enter_tree():
	# Add the new type
	add_custom_type("AnimatedText", "RichTextLabel", preload("res://addons/textanimator/animatedtext.gd"), preload("res://icon.svg"))
	
	# Add relevant tools to docks
	toolboxInstance = toolboxScene.instantiate()
	add_control_to_dock(DOCK_SLOT_LEFT_BR, toolboxInstance)
	
	animatorInstance = animatorScene.instantiate()
	add_control_to_bottom_panel(animatorInstance, "Text Animator")


func _exit_tree():
	# Remove the new type
	remove_custom_type("AnimatedText")
	
	# Remove relevant tools from docks
	remove_control_from_docks(toolboxInstance)
	toolboxInstance.queue_free()
	
	remove_control_from_bottom_panel(animatorInstance)
	animatorInstance.queue_free()
	
