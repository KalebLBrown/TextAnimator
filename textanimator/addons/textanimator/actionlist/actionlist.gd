class_name ActionList
extends Node

# The list of actions that get updated
var actions: Array[Action] = []

# Time dilation on the action list, if any
var timeDilation: float = 1.0

# Clear the action list
func ClearList():
	actions.clear()

# Add an action to the action list
func AddAction(action: Action):
	actions.append(action)

# Update all actions in the list, removing those that are finished
func UpdateList(dt: float):
	# Update each action in the list
	for i in actions.size():
		# Check if the action is supposed to update
		if(!actions[i].updating):
			actions[i].updating = true
			continue
		
		# If the action is supposed to update, update it
		if(actions[i].UpdateAction(dt)):
			# If the action is complete, destroy it
			actions[i].destroyed = true
		
		# Whatever tags the other objects in the list have, block them if they are blocked
		for act in actions:
			# Check against self
			if(act == actions[i]):
				continue
			
			# Walk through all tags and see if the action should be blocked
			for tag in actions[i].blocking:
				if(act.blockedBy.find(tag) != -1):
					act.updating = false
		
	# Iterate throught the list backwards and delete all destroyed actions
	var i: int = actions.size() - 1
	while (i >= 0):
		if(actions[i].destroyed):
			actions.remove_at(i)
		i -= 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dt: float = delta * timeDilation;
	UpdateList(dt)
