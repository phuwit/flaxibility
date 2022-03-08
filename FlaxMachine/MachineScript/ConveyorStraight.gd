extends Area2D

var cost = 5
var type = "ConveyorStraight"

var holding
var conveyorRotation = 'east'
var maxArrayIndex
var currentPos

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouseOver = false
var clickL = false
var clickR = false
var restNodePos


func _ready():
	maxArrayIndex = ((Global.gridColumn * 10) + Global.gridRows) + 1

func _process(delta):
	if (mouseOver == true) and (clickL == true):
		global_position = get_global_mouse_position()
	else:
		global_position = lerp(global_position, restNodePos, 10 * delta)

func _input(event):
	if (mouseOver == true) and (event is InputEventMouseButton) and (event.pressed == true):
		if (event.button_index == BUTTON_LEFT):
			get_tree().set_input_as_handled()
			clickL = true
		if (event.button_index == BUTTON_RIGHT):
			get_tree().set_input_as_handled()
			print('R just pressed')
			clickR = true
			rotate_conveyor()
	elif (event is InputEventMouseButton) and (event.pressed == false):
		if (event.button_index == BUTTON_LEFT):
			clickL = false
			snap_to_nearest_rest_node()
		if Input.is_mouse_button_pressed(BUTTON_RIGHT) == false:
			get_tree().set_input_as_handled()
			print('R just not pressed')
			clickR = false

func snap_to_nearest_rest_node():
	for child in Global.allRestNodes:
		var distanceToRest = global_position.distance_to(child.global_position)
		if distanceToRest < shortestDist and child.selected == false:
			currentPos = Global.restNodesGridPos.find(child)
			snap_to(child)

func snap_to(restNode):
	if currentNode:
		currentNode.selected = false
	restNode.select()
	restNode.machine = self
	print(restNode.machine.type)
	currentNode = restNode
	restNodePos = restNode.global_position

func snap_to_from_index(index):
	var snappingTarget = Global.allRestNodes[index]
	snap_to(snappingTarget)

func _on_ConveyorStraight_mouse_entered():
	mouseOver = true

func _on_ConveyorStraight_mouse_exited():
	mouseOver = false

func rotate_conveyor():
	var rotationsDirections = ['north', 'east', 'south', 'west']
#	var rotationsRadian = [0, 1.570796, 3.141593, 4.712389]
#	print(deg2rad(0), deg2rad(90), deg2rad(180), deg2rad(270))
	var newRotationsIndex = rotationsDirections.find(conveyorRotation) + 1
	if newRotationsIndex > (rotationsDirections.size() - 1):
		newRotationsIndex -= rotationsDirections.size()
	conveyorRotation = rotationsDirections[newRotationsIndex]
	
	print(conveyorRotation)
	print(self.rotation_degrees)
	self.rotation_degrees += 90
#	self.rotation = lerp_angle(self.rotation, rotationsRadian[newRotationsIndex], 200)
	print(self.rotation_degrees)

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
	
	print(sourcePos, 'and', targetPos, 'and', Global.maxArrayIndex)
	
	if (sourcePos >= 0) and (sourcePos <= Global.maxArrayIndex) and (targetPos >= 0) and (targetPos <= Global.maxArrayIndex):
		var target = Global.restNodesGridPos[targetPos].machine
		print('target', target, target.input)
		var source = Global.restNodesGridPos[sourcePos].machine
		print('source', source, source.output)
		if source and (source.output != null):
			print('source.output != null')
			if target and (target.input == null) and (holding == null):
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
#				todo: throw invalid target error & clog
