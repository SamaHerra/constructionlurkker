extends ai_state


# Called when the node enters the scene tree for the first time.
func _switched_to() -> void:
	if active:
		stalker.nav.target_position = Vector3.ZERO
		#stalker.hide()
		run_to_pos(Vector3(randi_range(-5,5),randi_range(-5,5),randi_range(-5,5)))
	pass # Replace with function body.

func run_to_pos(pos:Vector3):
	stalker.nav.target_position = pos
	await get_tree().create_timer(3).timeout
	stalker.hide()
	await get_tree().create_timer(5).timeout
	stalker.states.switch_to_state("stalk")
	

func _physics_process(delta: float) -> void:
	if active:
		stalker.velocity = stalker.global_position.direction_to(stalker.nav.get_next_path_position())
		stalker.velocity *= stalker.speed
