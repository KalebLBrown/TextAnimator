# NOTE: NEVER change the text field directly, use the functions provided

#@tool
class_name AnimatedText
extends RichTextLabel

var actionlist: ActionList = ActionList.new()

## The raw string of the animated text
## NOTE: Do not include BBCode tags in this text, it can cause problems for
## the tag system
@export_multiline var rawText: String = ""

# The array of tags that are on each character in the rawText
var tags : Array = Array([])

func AddTag(tag: ST_AnimatedTag):
	# TODO: Put in tag algorithm
	
	for array in tags:
		array.append(tag)
	
	# Reset the real text
	text = ""
	
	# Update real text
	var rawTextIndex: int = 0
	
	for c in rawText:
		
		pass
	
	pass

func RemoveTag(tag: ST_AnimatedTag):
	# TODO: Put in tag algorithm
	pass

# NOTE: There's a limitation with this function, if you change the text
# length, the tags don't update with the text, causing possibility of offset
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
	# Since the actionlist is a node, we have to add it as a child at runtime
	add_child(actionlist)
	
	# Set the text to the rawText
	# TODO: Change this?
	text = rawText
	
	# Fill out the array to start
	for n in len(text):
		tags.append([])
	
	
	
#region Testing
	var dict = {"hi": 2, "world": 4, "gen": 6, "kenobi": 8}
	for key in dict:
		var abb: A_BBCode = A_BBCode.new(0, dict[key], key, self)
		actionlist.AddAction(abb)
#endregion
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
