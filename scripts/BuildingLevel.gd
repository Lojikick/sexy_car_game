extends Node3D

@export var modules: Array[PackedScene] = []
var amnt = 15
var rng = RandomNumberGenerator.new()
var offset = 20
var initObs = 0
var speed = 25
var new_module_spawn_offset = 3.5
var last_spawn_position = 0

# New variables
var total_movement = 0.0
var physics_fps = 60  # Adjust this to match your physics FPS setting

func _ready():
	for n in amnt:
		spawnModule(n * offset)

func _process(delta):
	var movement = speed * delta
	position.z += movement
	total_movement += movement

	# Apply an opposite force to all RigidBody2D nodes
	var compensating_force = Vector2(0, 0)  # Adjust if your level moves in other directions
	compensating_force.y = -speed / physics_fps  # Convert speed to force

	for module in get_children():
		if module is Node3D:  # Assuming modules are Node3D
			for child in module.get_children():
				if child is RigidBody2D:
					child.apply_central_force(compensating_force)

func spawnModule(n):
	var instance
	if initObs > 10:
		rng.randomize()
		var num = rng.randi_range(0, modules.size() - 1)
		instance = modules[num].instantiate()
	else:
		instance = modules[2].instantiate()
		initObs += 1


	instance.position.z = n * (-1)
	add_child(instance)
	last_spawn_position = n

	# Set initial positions for RigidBody2D objects
	for child in instance.get_children():
		if child is RigidBody2D:
			child.position.y -= total_movement  # Adjust initial Y position based on total level movement

func _on_level_barrier_area_entered(area: Area3D) -> void:
	if area.is_in_group("building_module"):
		var new_position = last_spawn_position + offset
		print(new_position)	
		spawnModule(new_position)
		
		
		var module_to_remove = area.get_parent()
		
		if is_instance_valid(module_to_remove) and module_to_remove != self:
			module_to_remove.queue_free()
		else:
			print("Warning: Could not find valid module to remove")
	

# Add this to your Module scene script
#class_name Module extends Node3D
#
#func _ready():
	#for child in get_children():
		#if child is RigidBody2D:
			#child.gravity_scale = 1.0  # Adjust as needed
			#child.lock_rotation = true  # Optional: prevents rotation if you don't want it
