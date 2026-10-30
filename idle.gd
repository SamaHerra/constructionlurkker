extends ai_state


func _ready() -> void:
	active = true

# Called when the node enters the scene tree for the first time.
func _switched_to() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if active:
		stalker.velocity = Vector3.ZERO
		stalker.hide()
		stalker.states.switch_to_state("stalk")
