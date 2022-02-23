extends Area2D


var cost = 40
var type = "Dyeing"

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouse_over = false
var clicked = false
var restPoint
var restNodes = []

func _ready():
	restNodes = get_tree().get_nodes_in_group('restZones')
	yield(get_tree().root, "ready")
	restPoint = restNodes[defaultNode].global_position
	currentNode = restNodes[defaultNode]
	restNodes[defaultNode].select()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (clicked == true) and (mouse_over == true) and (Global.RunButton == false) and Global.money >= cost:
		# global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		global_position = get_global_mouse_position()
	else:
		global_position = lerp(global_position, restPoint, 10 * delta)

func _input(event):
	if (mouse_over == true) and (event is InputEventMouseButton) and (event.button_index == BUTTON_LEFT) and (event.pressed == true):
		get_tree().set_input_as_handled()
		print("clicked", type)
		clicked = true
	elif (event is InputEventMouseButton) and (event.pressed == false):
		clicked = false
		snap_to_rest_node()

func snap_to_rest_node():
	for child in restNodes:
#		print('child.selected = ', child.selected)
		var distanceToRest = global_position.distance_to(child.global_position)
		if distanceToRest < shortestDist and child.selected == false:
			currentNode.selected = false
			child.select()
#			print('child = ', child)
			currentNode = child
			restPoint = child.global_position #พิกัดหน้าจอ
#			shortestDist = distanceToRest

func _on_MachineDyeing_mouse_entered():
	mouse_over = true
	# print("MOUSE OVER LAEW")

func _on_MachineDyeing_mouse_exited():
	mouse_over = false
	# print("MOUSE EXIT LAEW")
