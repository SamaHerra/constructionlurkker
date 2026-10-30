extends ai_state


# Called when the node enters the scene tree for the first time.
func _switched_to() -> void:
	if active:
		stalker.show()
		hunt()
	pass # Replace with function body.

func hunt():
	await get_tree().create_timer(randf_range(5,10)).timeout
	stalker.states.switch_to_state("hide")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if active:
		if stalker.player_location != stalker.nav.target_position:
			stalker.nav.target_position = stalker.player_location
		stalker.velocity = stalker.global_position.direction_to(stalker.nav.get_next_path_position())
		if stalker.global_position.distance_to(stalker.player_location) < 3:
			get_tree().reload_current_scene()
		stalker.velocity *= stalker.speed + 0.5
	pass
