extends CollisionShape2D

var cotton = 0
var thread = 0
var fabric = 0
var color_fabric = 0
var packedFabric = 0
var packedColor_fabric = 0





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):
#	while Global.RunButton == true:
#		if Global.allRestNodes[0].machine.type == "Loom":
#			if cotton >= 5:
#				cotton = cotton - 5
#				thread += 1
#				yield(get_tree().create_timer(0.25),"timeout")
#		elif Global.allRestNodes[0].machine.type == "Sewing":
#			if thread >= 5:
#				thread = thread - 5
#				fabric +=1
#				yield(get_tree().create_timer(0.25),"timeout")
#		elif Global.allRestNodes[0].machine.type == "Dyeing":
#			if fabric >= 1 and Global.color >= 1:
#				fabric = fabric - 1
#				color_fabric +=1
#				yield(get_tree().create_timer(0.25),"timeout")
#		elif Global.allRestNodes[0].machine.type == "Packager":
#			if fabric >= 100:
#				fabric = fabric - 100
#				packedFabric +=1
#				yield(get_tree().create_timer(0.25),"timeout")
#			elif color_fabric >= 100:
#				color_fabric = color_fabric - 100
#				packedColor_fabric += 1
#				yield(get_tree().create_timer(0.25),"timeout")
#		if cotton > 0 or thread > 0 or fabric > 0 or color_fabric > 0 or packedFabric > 0 or packedColor_fabric > 0:
#			if cotton > 0:
#				cotton = cotton - 1
#				$Level0Grid/GridMachine/CollisionShape01.cotton += 1
#				yield(get_tree().create_timer(0.25),"timeout")
#			if thread > 0:
#				thread = thread - 1
#				$Level0Grid/GridMachine/CollisionShape01.thread += 1
#				yield(get_tree().create_timer(0.25),"timeout")
#			if fabric > 0:
#				fabric = fabric - 1
#				$Level0Grid/GridMachine/CollisionShape01.fabric += 1
#				yield(get_tree().create_timer(0.25),"timeout")
#			if color_fabric > 0:
#				color_fabric = color_fabric - 1
#				$Level0Grid/GridMachine/CollisionShape01.color_fabric +=1
#				yield(get_tree().create_timer(0.25),"timeout")
#			if packedFabric > 0:
#				packedFabric = packedFabric - 1
#				$Level0Grid/GridMachine/CollisionShape01.packedFabric += 1
#				yield(get_tree().create_timer(0.25),"timeout")
#			if packedColor_fabric > 0:
#				packedColor_fabric = packedColor_fabric - 1
#				$Level0Grid/GridMachine/CollisionShape01.packedColor_fabric += 1
#				yield(get_tree().create_timer(0.25),"timeout")
	

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
