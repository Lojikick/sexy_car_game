extends Control

signal resume_game

@onready var cheese_label: Label = $Panel/Cheese_Panel/Cheese_Label
@onready var tomato_label: Label = $Panel/Tomato_Panel/Tomato_Label
@onready var onion_label: Label = $Panel/Onion_Panel/Onion_Label
@onready var mushroom_label: Label = $Panel/Mushroom_Panel/Mushroom_Label
@onready var pineapple_label: Label = $Panel/Pineapple_Panel/Pineapple_Label

func _ready():
	show()  # Hide the menu when the game starts

func show_menu():
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func hide_menu():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_play_pressed():
	get_tree().reload_current_scene()
	

func _on_quit_pressed():
	get_tree().quit()
