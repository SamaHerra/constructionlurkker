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



func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	if get_viewport().use_xr:
		$XRNode3D/XRCam.make_current()
		flash.reparent($XRNode3D/left_hand)
		flash.position = Vector3.ZERO
		flash.rotation = Vector3.ZERO
		cam.reparent($XRNode3D/right_hand)
		cam.scale /= 3
		cam.position = Vector3.ZERO
		cam.rotation = Vector3(0,90,-90)
	else:
		$XRNode3D.visible = false
		

func update_charges():
	flash_light.emit()
	charges.value = flash.charges

func _physics_process(delta):
	velocity.y += -gravity * delta
	var input:Vector2
	if get_viewport().use_xr:
		input = $XRNode3D/left_hand.get_vector2("primary")
		input.y = input.y *-1
		var rotation_input:Vector2=$XRNode3D/right_hand.get_vector2("primary")
		rotation_degrees.y -= rotation_input.x * 4
	else:
		input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = $XRNode3D/XRCam.global_transform.basis * Vector3(input.x, 0, input.y)
	if Input:
		player_move.emit(global_position)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed
	move_and_slide()
	
	
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and !get_viewport().use_xr:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	if Input.is_action_just_pressed("ui_cancel"):
		await get_tree().process_frame
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("flash"):
		flash_with_light()
	if Input.is_action_just_pressed("cam"):
		switch_to_cam()
		
func flash_with_light():
	if flash and !cam.visible:
			flash.flash()
			
func switch_to_cam():
	await get_tree().process_frame
	if cam.visible:
		cam.visible = false
		flash.visible = true
		$cam.stop()
	else:
		$cam.play()
		cam.visible = true
		flash.visible = false	
		


func _on_left_hand_button_pressed(action_name: String) -> void:
	if action_name == "trigger_click":
		flash_with_light()
	pass # Replace with function body.


func _on_right_hand_button_pressed(action_name: String) -> void:
	if action_name == "primary_click":
		switch_to_cam()
	pass # Replace with function body.
