extends CharacterBody3D

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 7.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.02
# Get the gravity from the project settings to be synced with RigidBody nodes.

const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

var gravity = 9.8

#fov variables:
#change FOV to variable if player can change it in ur game
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5
#Variables for head and camera
@onready var head = $Head
@onready var camera = $Head/Camera3D
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#unhandled input func, called every time player handles something
#Handles character movement
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		#movement = rotation multipled by sensitivitty by mouse
		#y anfle relative x distance
		head.rotate_y(-event.relative.x * SENSITIVITY) #head on y
		camera.rotate_x(-event.relative.y * SENSITIVITY)#camera on x axis
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	#direction based on where head is looking
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			#
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		#Can play amount with value to controll airborne value
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	#head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	#assigns position of camera to result of headbob function
	camera.transform.origin = _headbob(t_bob)
	#clamp fov when vel reaches super high 
	#var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	#var target_fov = BASE_FOV * FOV_CHANGE * velocity_clamped
	#camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()
	
	#FOV
	
func _headbob(time) -> Vector3:
	#returns vect 3 variable in the physics process
	var pos = Vector3.ZERO
	#assign y coord to sin of tbob * sin freq
	
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ/2) * BOB_AMP
	return pos
