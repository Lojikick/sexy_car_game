extends Node3D

@onready var pause_menu = $Menu
@onready var death_menu = $Death_Menu
@onready var win_menu = $Win_menu
@onready var player: CharacterBody3D = $Player
@onready var vegtable_ui: Control = $Vegtable_Ui

var rng = RandomNumberGenerator.new()
var paused = false
var alive = true
var won = false

var ingredients_left = {
	"tomato": 0,
	"mushrooms": 0,
	"cheese": 3,
	"onion": 0,
	"pineapple":0,
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	rng.randomize()
	ingredients_left["tomato"] = 1
	ingredients_left["cheese"] = rng.randi_range(1, 2)
	ingredients_left["mushrooms"] = rng.randi_range(0, 2)
	ingredients_left["onion"] = rng.randi_range(0, 1)
	ingredients_left["pineapple"] = rng.randi_range(0, 1)
	
	
	#CHEESU#
	var str_result = str(ingredients_left["cheese"]) + "x"
	vegtable_ui.cheese_label.text = str_result
	#TOMATO#
	str_result = str(ingredients_left["tomato"]) + "x"
	vegtable_ui.tomato_label.text = str_result
	#ONION#
	str_result = str(ingredients_left["onion"]) + "x"
	vegtable_ui.onion_label.text = str_result
	#MUSHROOM#
	str_result = str(ingredients_left["mushrooms"]) + "x"
	vegtable_ui.mushroom_label.text = str_result
	
	str_result = str(ingredients_left["pineapple"]) + "x"
	vegtable_ui.pineapple_label.text = str_result
	print("Initialized the ingredients", ingredients_left)
	Engine.time_scale = 1
	pass # Replace with function body.

func check_ingredients():
	for ingredient in ingredients_left.keys():
		print
		if ingredients_left[ingredient] != 0 and  player.ingredients_collected[ingredient] < ingredients_left[ingredient]:
			return false
	return true

# Then you can use it like this:


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#check if player completed objectives:
	if not won and check_ingredients():
		#Replace with with menu
		print("you won the game!")
		won = true
		pauseMenu()
		#won = true
		#get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		#get_tree().paused = true
		#await get_tree().create_timer(1.0).timeout
		## Change to the main menu scene
		## Unpause the tree for the new scene
		#get_tree().paused = false
		
	if Input.is_action_just_pressed("escape"):
		pauseMenu()
		
func get_ing_diff(ingr_name: String):
	if (ingredients_left[ingr_name] == 0 or player.ingredients_collected[ingr_name] >= ingredients_left[ingr_name]):
		return 0
	else:
		return abs(player.ingredients_collected[ingr_name] - ingredients_left[ingr_name])
func pauseMenu():
	print("Current player status:", alive)
	if paused:
		if alive:
			pause_menu.hide_menu()
			Engine.time_scale = 1
		else:
			Engine.time_scale = 1
	else:
		if won:
			win_menu.show_menu()
			Engine.time_scale = 0
		elif alive:
			pause_menu.show_menu()
			Engine.time_scale = 0
		else:
			death_menu.show_menu()
			Engine.time_scale = 0
	paused = !paused
