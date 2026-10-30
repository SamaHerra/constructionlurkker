class_name stalk extends CharacterBody3D

@export var nav: NavigationAgent3D
@export var states: state
@export var sight: RayCast3D
@export var speed:float=3.0
@export var plr:player
@export var nav_reg: NavigationRegion3D


var teleport_cooldown:int = 0

var player_location:Vector3=Vector3.ZERO

func _physics_process(delta: float) -> void:
	move_and_slide()
	if randi_range(0,1500) >= 1475 and teleport_cooldown < 1:
		random_teleport()
		teleport_cooldown = 500
	else:
		if !teleport_cooldown < 1:
			teleport_cooldown -= 1
	if plr.cam.battery < 1 and plr.flash.charges < 1:
		states.switch_to_state("hunt")

func random_teleport():
	var to:Vector3
	if randi_range(0,1) == 1:
		to = NavigationServer3D.map_get_closest_point(nav_reg.get_navigation_map(),Vector3(randi_range(-15,15),0,randi_range(-15,15)) + player_location)
	else:
		to = NavigationServer3D.map_get_random_point(nav_reg.get_navigation_map(),1,true)
	global_position = to
	print(to)

func _on_plr_player_move(pos: Vector3) -> void:
	player_location = pos
	sight.target_position = to_local(pos)
	pass # Replace with function body.
