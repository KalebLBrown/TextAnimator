#@tool
extends RichTextLabel

var actionlist: ActionList = ActionList.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var action: TestAction = TestAction.new(3.0, 1.0)
	actionlist.AddAction(action)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	actionlist._process(delta)
	pass
