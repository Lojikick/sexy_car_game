extends Node3D

@onready var pause_menu = $Menu
@onready var death_menu = $Death_Menu
var paused = false
var alive = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		pauseMenu()

func pauseMenu():
	if paused:
		if alive:
			pause_menu.hide_menu()
			Engine.time_scale = 1
		else:
			Engine.time_scale = 1
	else:
		if alive:
			pause_menu.show_menu()
			Engine.time_scale = 0
		else:
			death_menu.show_menu()
			Engine.time_scale = 0
	paused = !paused
