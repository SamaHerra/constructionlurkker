class_name flashlight extends SpotLight3D

@export var flicker_chance:int=5

signal update

var charges = 5

var cooldown = 0

func flash():
	if cooldown > 0 or charges < 1:
		return
	charges -= 1
	update.emit()
	cooldown = 160
	light_energy = 10

var original_energy:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_energy = light_energy
	pass # Replace with function body.

func flicker():
	light_energy = lerpf(light_energy,randf_range(0.0,0.4),randf_range(0.05,0.9))

func _physics_process(delta: float) -> void:
	if cooldown > 0:
		cooldown -= 1
	if flicker_chance == randi_range(0,flicker_chance):
		flicker()
	else:
		light_energy = lerpf(light_energy,original_energy,delta * randf_range(0.5,5))
		
