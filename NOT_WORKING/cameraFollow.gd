extends Camera3D

##@onready var target: Object = get_parent().get_parent().get_parent().get_parent().get_node("Player")
##@export var smooth_speed: float
##@export var offset: Vector3

# Called every frame. 'delta' is the elapsed time since the previous frame.
##func _physics_process(delta: float) -> void:
	##if (target != null):
		##self.position = lerp(self.position, target.position, smooth_speed * delta)
