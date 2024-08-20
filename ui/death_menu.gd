extends Control

signal resume_game

func _ready():
	hide()  # Hide the menu when the game starts

func show_menu():
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func hide_menu():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_play_pressed():
	get_tree().reload_current_scene()
	MouseRadio.play_big_song()
	

func _on_quit_pressed():
	get_tree().quit()
