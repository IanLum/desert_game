class_name InteractableComponent
extends Area2D

@export var DIALOGUE_FILE: String

var dialogue_info: Dictionary
var dialogue_tree: Dictionary

var interaction_count: Dictionary
var branch_interaction_limits: Dictionary

func _ready():
	var dialogue_dict = DialogueParser.parse("test2.idmu")
	dialogue_info = dialogue_dict["info"]
	dialogue_tree = dialogue_dict["tree"]
	Events.interaction_complete.connect(_on_interaction_complete)
	
#	var dialogue_json = load_dialogue_json()
	init_iteraction_count(dialogue_tree)
	init_branch_interaction_limits(dialogue_tree)
	print(interaction_count)
	print(branch_interaction_limits)

func load_dialogue_json():
	var dialogue_path = "res://assets/dialogue/%s" % DIALOGUE_FILE
	assert(FileAccess.file_exists(dialogue_path), "Dialog file at %s does not exist" % dialogue_path)
	return JSON.parse_string(
		FileAccess.open(
			dialogue_path, FileAccess.READ
		).get_as_text()
	)

func init_iteraction_count(dialogue_tree):
	for branch in dialogue_tree:
		interaction_count[branch] = 0
	
func init_branch_interaction_limits(dialogue_tree):
	for branch in dialogue_tree:
		branch_interaction_limits[branch] = dialogue_tree[branch].keys().map(
			func(limit): return int(limit)
		)

func _on_interaction_complete(npc_node, branch):
	if npc_node == self:
		interaction_count[branch] += 1
