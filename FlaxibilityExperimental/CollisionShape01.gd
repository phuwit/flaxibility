extends CollisionShape2D

var cotton = 0
var thread = 0
var fabric = 0
var color_fabric = 0
var packedFabric = 0
var packedColor_fabric = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _process(delta):
	print("thread2 :"+str(thread))
	print("cotton2 :"+str(cotton))
#	if Global.allRestNodes[1].machine.type == "Loom":
#		if cotton >= 5:
#			cotton = cotton - 5
#			thread += 1
#			yield(get_tree().create_timer(0.25),"timeout")
#	elif Global.allRestNodes[1].machine.type == "Sewing":
#		if thread >= 5:
#			thread = thread - 5
#			fabric +=1
#			yield(get_tree().create_timer(0.25),"timeout")
#	elif Global.allRestNodes[1].machine.type == "Dyeing":
#		if fabric >= 1 and Global.color >= 1:
#			fabric = fabric - 1
#			color_fabric +=1
#			yield(get_tree().create_timer(0.25),"timeout")
#	elif Global.allRestNodes[1].machine.type == "Packager":
#		if fabric >= 100:
#			fabric = fabric - 100
#			packedFabric +=1
#			yield(get_tree().create_timer(0.25),"timeout")
#		elif color_fabric >= 100:
#			color_fabric = color_fabric - 100
#			packedColor_fabric += 1
#			yield(get_tree().create_timer(0.25),"timeout")
#	if cotton > 0 or thread > 0 or fabric > 0 or color_fabric > 0 or packedFabric > 0 or packedColor_fabric > 0:
#		while cotton > 0:
#			cotton = cotton - 1
#			$Level0Grid/GridMachine/CollisionShape11.cotton += 1
#			yield(get_tree().create_timer(0.25),"timeout")
#		while thread > 0:
#			thread = thread - 1
#			$Level0Grid/GridMachine/CollisionShape11.thread += 1
#			yield(get_tree().create_timer(0.25),"timeout")
#		while fabric > 0:
#			fabric = fabric - 1
#			$Level0Grid/GridMachine/CollisionShape11.fabric += 1
#			yield(get_tree().create_timer(0.25),"timeout")
#		while color_fabric > 0:
#			color_fabric = color_fabric - 1
#			$Level0Grid/GridMachine/CollisionShape11.color_fabric +=1
#			yield(get_tree().create_timer(0.25),"timeout")
#		while packedFabric > 0:
#			packedFabric = packedFabric - 1
#			$Level0Grid/GridMachine/CollisionShape11.packedFabric += 1
#			yield(get_tree().create_timer(0.25),"timeout")
#		while packedColor_fabric > 0:
#			packedColor_fabric = packedColor_fabric - 1
#			$Level0Grid/GridMachine/CollisionShape11.packedColor_fabric += 1
#			yield(get_tree().create_timer(0.25),"timeout")


func _on_Timer_timeout():
	pass # Replace with function body.
