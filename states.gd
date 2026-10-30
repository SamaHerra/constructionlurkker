class_name state extends Node

@onready var current_state:ai_state=$IDLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func switch_to_state(state_name:String):
	state_name = state_name.to_upper()
	for child:ai_state in get_children():
		if child.name.to_upper() == state_name:
			current_state = child
			child.active = true
			child._switched_to()
		else:
			child.active = false
		pass
		
		
