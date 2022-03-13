extends Area2D


var cost = 40
var type = "Dyeing"

var input
var output

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouseOver = false
var clicked = false
var restNodePos
#var allRestNodes = [] #moved to Global.allRestNodes

#func _ready():
#	print(Global.allRestNodes)
#	print(get_tree().root)
#	yield(get_tree().root, "ready")
#	snap_to_from_index(defaultNode)
#	print("Global.allRestNodes :"+str(Global.allRestNodes))

func _process(delta):
	if (clicked == true) and (mouseOver == true) and (Global.RunButton == false) and Global.money >= cost:
		# global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		global_position = get_global_mouse_position()
	else:
		global_position = lerp(global_position, restNodePos, 10 * delta)

func _input(event):
	if (mouseOver == true) and (event is InputEventMouseButton) and (event.button_index == BUTTON_LEFT) and (event.pressed == true):
		get_tree().set_input_as_handled()
#		print("clicked", type)
		clicked = true
	elif (event is InputEventMouseButton) and (event.pressed == false):
		clicked = false
		snap_to_nearest_rest_node()

func snap_to_nearest_rest_node():
	for child in Global.allRestNodes:
#		print('child.selected = ', child.selected)
		var distanceToRest = global_position.distance_to(child.global_position)
		if distanceToRest < shortestDist and child.selected == false:
			snap_to(child)

func snap_to(restNode):
#	print('restNode')
#	print(restNode)
#	print(restNode.selected)
	if currentNode:
		currentNode.selected = false
#		print('currentNode')
#		print(currentNode)
#		print(currentNode.selected)
	restNode.select()
	restNode.machine = self
	print(restNode.machine.type)
	print(restNode)
	currentNode = restNode
	restNodePos = restNode.global_position

#func snap_to_from_index(y, x):
#	var snappingTarget = Global.allRestNodes[y][x]
#	snap_to(snappingTarget)

func _on_MachineDyeing_mouse_entered():
	mouseOver = true
	# print("MOUSE OVER LAEW")

func _on_MachineDyeing_mouse_exited():
	mouseOver = false
	# print("MOUSE EXIT LAEW")
