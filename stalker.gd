class_name stalk extends CharacterBody3D

@export var nav: NavigationAgent3D
@export var states: state
@export var sight: RayCast3D
@export var speed:float=3.0
@export var plr:player


var player_location:Vector3=Vector3.ZERO

func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_plr_player_move(pos: Vector3) -> void:
	player_location = pos
	sight.target_position = to_local(pos)
	pass # Replace with function body.
