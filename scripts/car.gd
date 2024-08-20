extends CharacterBody3D


const SPEED = 15
const JUMP_VELOCITY = 4.5

#@onready var pivot = $CamRoot
@export var sens = 0.5

#Death Sensor, For collisions
#@onready var death_sensor = $RayCast3D


#For death timer
@onready var timer: Timer = $Timer


#Variables for Transition
@onready var small_car = false
var is_transitioning = false

@export var transition_duration = 0.5
@onready var tween: Tween
@onready var death_sensor = $Death_Sensor
@onready var death_menu = $"../Death_Menu"
@onready var menu_ui = $"../Menu"
@onready var game_manager = $".."
@onready var level: Node3D = $"../Level"
@onready var building_level: Node3D = $"../BuildingLevel"
@onready var explosion: Node3D = $Explosion





# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	tween = create_tween()
	tween.stop()
	#Captures our mouse so that it doesnt go beyond the game screen
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	menu_ui.connect("resume_game", Callable(self, "_on_resume_game"))
#Handles 3D camera movement
func _input(event):
	pass
	#if event is InputEventMouseMotion:
		## LEFT AND RIGHT #Y AXIS: Rotate entire character:
		##rotate_y(deg_to_rad(-event.relative.x * sens))
		### UP AND DOWN #X AXIS: Rotate camera:
		##pivot.rotate_x(deg_to_rad(-event.relative.y * sens))
		##Check to make sure camera does not go over player
		#pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(45))
		

# Small Big Transition Functions
func toggle_car_size():
	is_transitioning = true
	
	#stopps ongoing tweens
	if tween and tween.is_valid():
		tween.kill()
	#creates tween
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	var target_scale: Vector3
	if not small_car:
		target_scale = Vector3(0.05, 0.05, 0.05) 
	
	else:
		target_scale = Vector3(1.9, 1.9, 1.9) 
	
	
	#animate the scale:
	tween.tween_property(self, "scale", target_scale, transition_duration)
	
	# Connect finished signal to function
	tween.connect("finished", Callable(self, "_finished_transition"))
	
	# Small car now true
	small_car = not small_car
	if small_car:
		death_sensor.set_collision_mask_value(3, true)
	else:
		death_sensor.set_collision_mask_value(3, false)
		
func _finished_transition():
	is_transitioning = false
	
	if small_car:
		MouseRadio.play_small_song()
	else:
		MouseRadio.play_big_song()
		
	
#Death/ Level Reload Functions
func death():
	level.speed = 0
	building_level.speed = 0
	timer.start()
	explosion.explode()

	#game_manager.alive = false
	#game_manager.pauseMenu()

#Physics Process
func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	#Handle player exiting of the game:
	#if death_sensor.is_colliding():
		#print("Collision detected!")
		#death()
		#get_tree().reload_current_scene()
	if Input.is_action_just_pressed("switch") and not is_transitioning:
		toggle_car_size()
		
	#if Input.is_action_just_pressed("escape"):
		##menu_ui.show_menu()
		##game_manager.pauseMenu()
		#menu_ui.show_menu()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _on_resume_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	game_manager.pauseMenu()

func _on_deatth_sensor_area_entered(area: Area3D) -> void:
	if area.is_in_group("car"):
		death()
	if area.is_in_group("cone"):
		death()
		#death()


func _on_timer_timeout() -> void:
	
	game_manager.alive = false
	game_manager.pauseMenu()
