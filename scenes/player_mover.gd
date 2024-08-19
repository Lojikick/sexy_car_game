extends Node3D


var SPEED = 23
@onready var player: CharacterBody3D = $Player
@onready var level_barrier: Area3D = $level_barrier

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement = SPEED * delta
	player.position.z -= movement
	level_barrier.position.z -= movement
