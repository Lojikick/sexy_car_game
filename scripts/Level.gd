extends Node3D

@export var modules: Array[PackedScene] = []
var amnt = 10
var rng  = RandomNumberGenerator.new()
var offset = 3.2

@export var buildingModules: Array[PackedScene] = []
##var buildingAmnt = 25
var buildingOffset = 3.2

var initObs = 0
var initBuildings = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#spawn modules 10 times, input is module_num * offset
	for n in amnt:
		spawnModule(n*offset)
		"""
		spawnBuilding(n*buildingOffset)
		"""
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
		
		#var buildingNum = rng.randi_range(0,buildingModules.size()-1)
		
		#instantiate a random module from our array
		var instance = modules[num].instantiate()
		
		#var buildingInstance = buildingModules[buildingNum].instantiate()
		#instantiate with instantiate()
		#position:
		instance.position.z = n*(-1)
		add_child(instance)
		
		#buildingInstance.position.z = n*(-1)
		#buildingInstance.position.x = -10
		#add_child(buildingInstance)
	else:
		var instance = modules[0].instantiate()
		
		#var buildingInstance = buildingModules[0].instantiate()
		
		instance.position.z = n*(-1)
		add_child(instance)
		
		#buildingInstance.position.z = n*(-1)
		#buildingInstance.position.x = -10
		#add_child(buildingInstance)
		
		initObs += 1
		
"""
func spawnBuilding(n):
	if initObs > 10:
	#randomize random number generator
		rng.randomize()
		#set a variable to pick a random number between 0 and our arr len
		var num = rng.randi_range(0,modules.size()-1)
		
		#var buildingNum = rng.randi_range(0,buildingModules.size()-1)
		
		#instantiate a random module from our array
		var instance = buildingModules[num].instantiate()
		
		#var buildingInstance = buildingModules[buildingNum].instantiate()
		#instantiate with instantiate()
		#position:
		instance.position.z = n*(-1)
		add_child(instance)
		
		#buildingInstance.position.z = n*(-1)
		#buildingInstance.position.x = -10
		#add_child(buildingInstance)
	else:
		var instance = modules[0].instantiate()
		
		#var buildingInstance = buildingModules[0].instantiate()
		
		instance.position.z = n*(-1)
		add_child(instance)
		
		#buildingInstance.position.z = n*(-1)
		#buildingInstance.position.x = -10
		#add_child(buildingInstance)
		
		initObs += 1
"""
