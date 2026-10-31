class_name player extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.002

signal player_move(pos:Vector3)
signal flash_light

@export var flash: flashlight
@export var charges: TextureProgressBar
@export var cam: Node3D




func update_charges():
	flash_light.emit()
	charges.value = flash.charges

func _physics_process(delta):
	velocity.y += -gravity * delta
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	if Input:
		player_move.emit(global_position)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed
	move_and_slide()
	
	
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	if Input.is_action_just_pressed("ui_cancel"):
		await get_tree().process_frame
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("flash") and !cam.visible:
		if flash:
			flash.flash()
	if Input.is_action_just_pressed("cam"):
		await get_tree().process_frame
		if cam.visible:
			cam.visible = false
			flash.visible = true
			$cam.stop()
		else:
			$cam.play()
			cam.visible = true
			flash.visible = false
		
	
			
		
