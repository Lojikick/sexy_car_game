extends Area3D
@onready var honk_one: AudioStreamPlayer3D = $"../Honk_One"
@onready var honk_two: AudioStreamPlayer3D = $"../Honk_Two"
@onready var honk_three: AudioStreamPlayer3D = $"../Honk_Three"

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		rng.randomize()
		var num = rng.randi_range(0,15)
		if num == 7:
			honk_one.play()
		elif num == 8:
			honk_two.play()
		elif num == 9:
			honk_three.play()
			
			
				
