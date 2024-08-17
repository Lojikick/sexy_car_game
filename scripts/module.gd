extends Node3D

#Direct parent reference
@onready var level = $"../"
var speed = 30


# Called when the node enters the scene tree for the first time.
func _process(delta):
	#Continuously subtract position by speed
	position.z += speed * delta
	#if our position is behind the camera range
	if position.z > 5:
		level.spawnModule(position.z+(level.amnt*2.8))
		queue_free()
		#Spawn a nrew module at following position:
			#position.x * level.amt*level.offset
			#delete modules
			#qeue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

