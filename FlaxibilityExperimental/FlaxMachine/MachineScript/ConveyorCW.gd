extends Area2D

var cost = 5
var type = "ConveyorCW"

var holding
var conveyorRotation #target location
var maxArrayIndex
var currentPos

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouseOver = false
var clicked = false
var restNodePos


func _ready():
	print(Global.gridColumn)
	print(Global.gridRows)
	maxArrayIndex = ((Global.gridColumn * 10) + Global.gridRows) + 1

func _process(delta):
	if (clicked == true) and (mouseOver == true):
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
#	var index = -1
	
	for child in Global.allRestNodes:
#		index += 1
#		print('child.selected = ', child.selected)
		var distanceToRest = global_position.distance_to(child.global_position)
		if distanceToRest < shortestDist and child.selected == false:
#			currentPos = index_to_pos(index)
			currentPos = Global.restNodesGridPos.find(child)
			snap_to(child)
#			print("child : "+str(child))

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

func _on_ConveyorCW_mouse_entered():
	mouseOver = true

func _on_ConveyorCW_mouse_exited():
	mouseOver = false

func index_to_pos(index):
	var posX = 0
	var posY = 0
	
	for i in index:
		print('index', index)
		print('posX', posX)
		if posX > Global.gridRows:
			posX = 0
			posY += 1
		posX += 1
	return ((posY * 10) + posX)

func move_items():
	var targetPos
	var sourcePos
	
	match conveyorRotation:
		'north':
			targetPos = currentPos - 10
			sourcePos = currentPos + 1
		'east':
			targetPos = currentPos + 1
			sourcePos = currentPos + 10
		'south':
			targetPos = currentPos + 10
			sourcePos = currentPos - 1
		'west':
			targetPos = currentPos + 10
			sourcePos = currentPos - 1
	
	print(sourcePos, 'and', targetPos, 'and', Global.maxArrayIndex)
	
	if (sourcePos >= 0) and (sourcePos <= Global.maxArrayIndex) and (targetPos >= 0) and (targetPos <= Global.maxArrayIndex):
		var target = Global.restNodesGridPos[targetPos].machine
		print('target', target, target.input)
		var source = Global.restNodesGridPos[sourcePos].machine
		print('source', source, source.output)
		if source and source.output != null:
			print('source.output != null')
			if target and target.input == null and holding == null:
				print('target.input != null')
				holding = source.output
				source.output = null
				get_node("HoldingLabel").text = holding
#				todo: play anim
				yield(get_tree().create_timer(0.5), "timeout")
				target.input = holding
				holding = null
				get_node("HoldingLabel").text = 'text'
				return true
			else:
				return false
#				throw invalid target error & clog
