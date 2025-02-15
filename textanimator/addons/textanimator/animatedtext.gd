# NOTE: NEVER change the text field directly, use the functions provided

@tool
class_name AnimatedText
extends RichTextLabel

var actionlist: ActionList = ActionList.new()

# List of Action Factories that are added to the action list
@export var startingActions : Array[ActionFactory] = []

# Add a starting action at edit time
func AddStartingAction(factory: ActionFactory) -> void:
	var newArray = startingActions.duplicate()
	newArray.append(factory)
	startingActions = newArray
	notify_property_list_changed()

func RemoveStartingAction(factory: ActionFactory) -> void:
	var newArray = startingActions.duplicate()
	newArray.erase(factory)
	startingActions = newArray
	notify_property_list_changed()

func ClearStartingActions() -> void:
	startingActions.clear()
	notify_property_list_changed()

## The raw string of the animated text
## NOTE: Do not include BBCode tags in this text, it can cause problems for
## the tag system
@export_multiline var rawText: String = ""

# The array of tags that are on each character in the rawText
var tags : Array = Array([])

# TODO: See if there's a more elegant solution to this problem
func RemakeText():
	# Reset the real text
	text = ""
	
	# Keep track of the stack of tags
	var tagStack : Array 
	
	# Update real text
	for i in len(rawText):
		# First, check for tags that end here
		for j in range(len(tagStack) - 1, -1, -1):
			if(tagStack[j].end == i):
				text += tagStack[j].GetEndTag()
				tagStack.pop_back()
			# If the topmost tag doesn't end here, then no tags end. Stop
			else:
				break
		
		# Now, check for tags that start here
		for t in tags[i]:
			if(t.start == i):
				# Check for overlap
				if(len(tags[i]) == 1):
					# If no overlap, just push it
					tagStack.push_back(t)
					text += t.GetStartTag()
				else:
					# If there is overlap, pop all tags 
					for j in range(len(tagStack) - 1, -1, -1):
						text += tagStack[j].GetEndTag()
						tagStack.pop_back()
					
					# Push in reverse order from which they end
					var tagArr: Array = tags[i]
					tagArr.sort_custom(_sortTagEndDescending)
					
					for ta in tagArr:
						tagStack.push_back(ta)
						text += ta.GetStartTag()
					
					pass
				
				pass
			pass
		
		# Append the next character
		text += rawText[i]
	
	print_debug(text)
	pass

# Internal private sorting (basically a lambda, but not)
func _sortTagEndDescending(a: ST_AnimatedTag, b: ST_AnimatedTag):
	if(a.end > b.end):
		return true
	return false

func AddTag(tag: ST_AnimatedTag):
	# Append the tag where it should go
	for i in len(tags):
		if(i >= tag.start && i <= tag.end):
			tags[i].append(tag)
	
	RemakeText()

func RemoveTag(tag: ST_AnimatedTag):
	for i in len(tags):
		if(i >= tag.start && i <= tag.end):
			tags[i].erase(tag)
	
	RemakeText()

# NOTE: There's a limitation with this function, if you change the text
# length, the tags don't update with the text, causing possibility of offset tags
func ChangeText(newText: String) -> void:
	# Change the text
	rawText = newText
	
	# Update the tag length according to the new string length
	var newtags : Array = Array([])
	
	# Copy the data from the old tags into new tags
	for i in len(rawText):
		newtags.append(Array([], TYPE_OBJECT, "ST_AnimatedTag", null))
		
		# Prevent OOB access on tags
		if(len(tags) <= i):
			continue
		
		for j in len(tags[i]):
			newtags[i].append(tags[i][j])
	
	
	# Update tags and raw text
	tags = newtags
	
	text = rawText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set the text to the rawText
	# TODO: Change this?
	text = rawText
	
	if Engine.is_editor_hint():
		# If in editor, don't do anything
		return
	
	# Since the actionlist is a node, we have to add it as a child at runtime
	add_child(actionlist)
	
	# Fill out the array to start
	for n in len(text):
		tags.append([])
	
	# Add all the actions that the text should start with
	for res in startingActions:
		# Construct the action
		var act : Action = res.ActionScript.MakeFromFactory(res)
		
		if("_label" in act):
			act._label = self
		
		print(res.ActionScript)
		print(res.Parameters)
		actionlist.AddAction(act)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		# If in editor, set text to rawtext
		text = rawText
		return
	
