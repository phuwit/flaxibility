extends Area2D

var cost = 5
var type = "ConveyorStraight"

var holding
var conveyorRotation
var maxArrayIndex
var currentPos

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouse_over = false
var clicked = false
var restNodePos


func _ready():
#	print(Global.allRestNodes)
	yield(get_tree().root, "ready")
	snap_to_from_index(defaultNode)
#	print("Global.allRestNodes :"+str(Global.allRestNodes))
	
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
	for child in Global.allRestNodes:
#		print('child.selected = ', child.selected)
		var distanceToRest = global_position.distance_to(child.global_position)
		if distanceToRest < shortestDist and child.selected == false:
			snap_to(child)
			print("child : "+str(child))

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
	var snappingTarget = Global.allRestNodes[index]
	snap_to(snappingTarget)

func move_items():
	var targetPos
	var sourcePos
	match conveyorRotation:
		'north':
			targetPos = currentPos - 10
			sourcePos = currentPos + 10
		'east':
			targetPos = currentPos + 1
			sourcePos = currentPos - 1
		'south':
			targetPos = currentPos + 10
			sourcePos = currentPos - 10
		'west':
			targetPos = currentPos - 1
			sourcePos = currentPos - 1
	
	if 0 <= sourcePos <= maxArrayIndex and 0 <= targetPos <= maxArrayIndex:
		var target = Global.restNodesGridPos[targetPos].machine
		var source = Global.restNodesGridPos[sourcePos].machine
		if source.holding == true:
			if target:
				target.holding = holding
				holding = null
#				todo: play anim
				yield(get_tree().create_timer(0.5), "timeout")
#			else:
#				throw invalid target error & clog
				
