extends ai_state

var seen = false

func _ready() -> void:
	stalker.plr.flash_light.connect(flashed)

# Called when the node enters the scene tree for the first time.
func _switched_to() -> void:
	if active:
		seen = false
		stalker.show()
	pass # Replace with function body.

func flashed():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if active:
		if stalker.player_location != stalker.nav.target_position:
			stalker.nav.target_position = stalker.player_location + Vector3(randi_range(-3,3),0,randi_range(-3,3))
		if stalker.sight.is_colliding() and !seen:
			if stalker.sight.get_collider() is player and get_viewport().get_camera_3d().is_position_in_frustum(stalker.global_position) and stalker.global_position.distance_to(stalker.player_location) < 6:
				seen = true
				await get_tree().create_timer(0.5).timeout
				if randi_range(0,5) >= 4:
					stalker.states.switch_to_state("hunt")
				else:
					if stalker.plr.flash.charges < 1 or stalker.plr.cam.visible:
						stalker.states.switch_to_state("hunt")
					else:
						stalker.states.switch_to_state("hide")
		if stalker.global_position.distance_to(stalker.player_location) < 0.2:
			get_tree().reload_current_scene()
		stalker.velocity = stalker.global_position.direction_to(stalker.nav.get_next_path_position())
		stalker.velocity *= stalker.speed / 3
	pass
