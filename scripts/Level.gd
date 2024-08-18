extends Node3D

@export var modules: Array[PackedScene] = []
var amnt = 25
var rng  = RandomNumberGenerator.new()
var offset = 3.2

var initObs = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#spawn modules 10 times, input is module_num * offset
	for n in amnt:
		spawnModule(n*offset)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#function to spawn module

func spawnModule(n):
	if initObs > 10:
	#randomize random number generator
		rng.randomize()
		#set a variable to pick a random number between 0 and our arr len
		var num = rng.randi_range(0,modules.size()-1)
		
		#instantiate a random mosule from our array
		var instance = modules[num].instantiate()
		#instantiate with instantiate()
		#position:
		instance.position.z = n*(-1)
		add_child(instance)
	else:
		var instance = modules[0].instantiate()
		instance.position.z = n*(-1)
		add_child(instance)
		initObs += 1
