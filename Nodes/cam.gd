extends Node3D

var battery:int=100
@export var light: SpotLight3D
@export var camera_3d: Camera3D

var env:Environment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	env = camera_3d.environment
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if visible:
		battery -= 1
		env.volumetric_fog_density += 0.0025
		$MeshInstance3D.mesh.material.emission_energy_multiplier -= $MeshInstance3D.mesh.material.emission_energy_multiplier / 50
		if battery < 1:
			light.visible = false
			
	pass # Replace with function body.
