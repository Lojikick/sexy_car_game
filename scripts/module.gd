extends Node3D

#Direct parent reference
@onready var level = $"../"
var speed = 25
var new_module_spawn_offset = 4



# Called when the node enters the scene tree for the first time.
func _process(delta):
	#Continuously subtract position by speed
	#position.z += speed * delta
	#if our position is behind the camera range
	if position.z > 4.6:
		#pass in packed car variable
		#level.spawnModule(position.z+(level.amnt*new_module_spawn_offset))
		queue_free()
		#Spawn a nrew module at following position:
			#position.x * level.amt*level.offset
			#delete modules
			#qeue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
