extends Area2D

var cost = 5
var type = "ConveyorCW"

var holding
var conveyorRotation = 'east'
var maxArrayIndex
var currentPosY
var currentPosX

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouseOver = false
var clickL = false
var clickR = false
var restNodePos


signal conveyor_invalid_target_or_source(currentPosY, currentPosX)
signal conveyor_target_busy(currentPosY, currentPosX)


func _ready():
#	print(Global.gridColumn)
#	print(Global.gridRows)
	maxArrayIndex = ((Global.gridColumn * 10) + Global.gridRows) + 1

func _process(delta):
	if (mouseOver == true) and (clickL == true):
		# global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		global_position = get_global_mouse_position()
#	elif (mouseOver == true) and (clickL == true) and (clickR == true):
	else:
		global_position = lerp(global_position, restNodePos, 10 * delta)

func _input(event):
	if (mouseOver == true) and (event is InputEventMouseButton) and (event.pressed == true):
		if (event.button_index == BUTTON_LEFT):
			get_tree().set_input_as_handled()
	#		print("clickL", type)
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
#	var index = -1
	for child in Global.allRestNodes:
#		index += 1
#		print('child.selected = ', child.selected)
		var distanceToRest = global_position.distance_to(child.global_position)
		if distanceToRest < shortestDist and child.selected == false:
			snap_to(child)
			currentPosY = child.posY
			currentPosX = child.posX
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

#func index_to_pos(index):
#	var posX = 0
#	var posY = 0
#
#	for i in index:
#		print('index', index)
#		print('posX', posX)
#		if posX > Global.gridRows:
#			posX = 0
#			posY += 1
#		posX += 1
#	return ((posY * 10) + posX)

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
	var targetPosY
	var targetPosX
	var sourcePosY
	var sourcePosX
	
	match conveyorRotation:
		'north':
			targetPosY = currentPosY - 1
			targetPosX = currentPosX
			sourcePosY = currentPosY
			sourcePosX = currentPosX + 1
		'east':
			targetPosY = currentPosY
			targetPosX = currentPosX + 1
			sourcePosY = currentPosY + 1
			sourcePosX = currentPosX
		'south':
			targetPosY = currentPosY + 1
			targetPosX = currentPosX
			sourcePosY = currentPosY
			sourcePosX = currentPosX - 1
		'west':
			targetPosY = currentPosY
			targetPosX = currentPosX - 1
			sourcePosY = currentPosY - 1
			sourcePosX = currentPosX
	
	if not (sourcePosY >= 0) and not (sourcePosX >= 0) and not (sourcePosY <= Global.gridColumn) and not (sourcePosX <= Global.gridRows) and not (targetPosY >= 0) and not (targetPosX >= 0) and not (targetPosY <= Global.gridColumn) and not (targetPosX <= Global.gridRows):
		emit_signal('conveyor_invalid_target_or_source', currentPosY, currentPosX)
		pass
	
	var target = Global.restNodesGridPos[targetPosY][targetPosX].machine
	print('target', target, target.input)
	var source = Global.restNodesGridPos[sourcePosY][sourcePosX].machine
	print('source', source, source.output)

	if (target == false) or (source == false):
		emit_signal('conveyor_invalid_target_or_source', currentPosY, currentPosX)
		pass

	if source and (source.output != null):
		print('source.output != null')
		if target and (target.input == null) and (holding == null):
			print('target.input != null')
			holding = source.output
			source.output = null
			get_node("HoldingLabel").text = holding
				# todo: play anim
			yield(get_tree().create_timer(0.5), "timeout")
			target.input = holding
			holding = null
			get_node("HoldingLabel").text = 'text'
			return true
		else:
			emit_signal('conveyor_target_busy', currentPosY, currentPosX)
			return false
