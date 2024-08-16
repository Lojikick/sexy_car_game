extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var pivot = $CamRoot
@export var sens = 0.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	#Captures our mouse so that it doesnt go beyond the game screen
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

#Handles 3D camera movement
func _input(event):
	
	if event is InputEventMouseMotion:
		# LEFT AND RIGHT #Y AXIS: Rotate entire character:
		rotate_y(deg_to_rad(-event.relative.x * sens))
		# UP AND DOWN #X AXIS: Rotate camera:
		pivot.rotate_x(deg_to_rad(-event.relative.y * sens))
		#Check to make sure camera does not go over player
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(45))
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handle player exiting of the game:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
