extends Node3D

var mushroom = preload("res://assets/ingredients/mushroom_ingredient.tscn")
var cheese = preload("res://assets/ingredients/cheese_ingredient.tscn")
var tomato = preload("res://assets/ingredients/tomato_ingredient.tscn")
var pineapple = preload("res://assets/ingredients/pinapple.tscn")
var onion = preload("res://assets/ingredients/onion.tscn")

func choose_ingredient():
	var ingredients = [mushroom, cheese, tomato, pineapple, onion]
	return ingredients[randi() % ingredients.size()]

func _ready() -> void:
	var chosen_ingredient = choose_ingredient()
	var instance = chosen_ingredient.instantiate()
	instance.position = Vector3(0, 0, 0)
	add_child(instance)

func _process(delta: float) -> void:
	pass
