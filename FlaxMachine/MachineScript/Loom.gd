extends Area2D


var cost = 30
var type = "Loom"

var input
var output

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouseOver = false
var clickL = false
var restNodePos
var outOfMoney = false

signal mouse_up
signal mouse_down
signal out_of_money(type)

#var allRestNodes = [] #moved to Global.allRestNodes

#func _ready():
#	print(Global.allRestNodes)
#	print(get_tree().root)
#	yield(get_tree().root, "ready")
#	snap_to_from_index(defaultNode)
#	print("Global.allRestNodes :"+str(Global.allRestNodes))

func _process(delta):
	if (clickL == true) and (Global.RunButton == false) and (outOfMoney == false):
		# global_position = lerp(global_positsion, get_global_mouse_position(), 25 * delta)
		global_position = get_global_mouse_position()
	else:
		global_position = lerp(global_position, restNodePos, 10 * delta)

func _on_MachineLoom_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if (event is InputEventMouseButton):
		if (Global.money >= cost):
			outOfMoney = false

			if (mouseOver == true) and (event.button_index == BUTTON_LEFT) and (event.pressed == true):
				clickL = true
				emit_signal("mouse_down")
			elif (event.pressed == false):
				clickL = false
				emit_signal("mouse_up")
				snap_to_nearest_rest_node()

			get_tree().set_input_as_handled()
	
		else:
			outOfMoney = true
			if (event.button_index == BUTTON_LEFT) and (event.pressed == true):
				emit_signal("out_of_money", type)

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
	restNode.machine = self
	restNode.select()
	# print(restNode.machine.type)
	# print(restNode)
	currentNode = restNode
	restNodePos = restNode.global_position

#func snap_to_from_index(y, x):
#	var snappingTarget = Global.allRestNodes[y][x]
#	snap_to(snappingTarget)

func _on_MachineLoom_mouse_entered():
	mouseOver = true
	# print("MOUSE OVER LAEW", type)

func _on_MachineLoom_mouse_exited():
	mouseOver = false
	# print("MOUSE EXIT LAEW", type
