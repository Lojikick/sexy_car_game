extends Node3D

@onready var debris: GPUParticles3D = $Debris
@onready var fire: GPUParticles3D = $Fire
@onready var smoke: GPUParticles3D = $Smoke
@onready var explosion_sound: AudioStreamPlayer3D = $"Explosion Sound"

func _ready():
	explode()
	
func explode():
	debris.emitting = true
	smoke.emitting = true
	fire.emitting = true
	explosion_sound.play()
	await get_tree().create_timer(2.0).timeout
	
