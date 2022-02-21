extends Area2D


var cost = 30
var type = "Loom"

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouse_over = false
var clicked = false
var restNodePos
var allRestNodes = []

func _ready():
	
#	print(allRestNodes)
	yield(get_tree().root, "ready")
	snap_to_from_index(defaultNode)
#	print("allRestNodes :"+str(allRestNodes))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (clicked == true) and (mouse_over == true):
		# global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		global_position = get_global_mouse_position()
	else:
		global_position = lerp(global_position, restNodePos, 10 * delta)

func _input(event):
	if (mouse_over == true) and (event is InputEventMouseButton) and (event.button_index == BUTTON_LEFT) and (event.pressed == true):
		get_tree().set_input_as_handled()
#		print("clicked", type)
		clicked = true
	elif (event is InputEventMouseButton) and (event.pressed == false):
		clicked = false
		snap_to_nearest_rest_node()

func snap_to_nearest_rest_node():
	for child in allRestNodes:
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
	currentNode = restNode
	restNodePos = restNode.global_position

func snap_to_from_index(index):
	var snappingTarget = allRestNodes[index]
	snap_to(snappingTarget)

func _on_MachineLoom_mouse_entered():
	mouse_over = true
#	print("MOUSE OVER LAEW", type)

func _on_MachineLoom_mouse_exited():
	mouse_over = false
#	print("MOUSE EXIT LAEW", type)
