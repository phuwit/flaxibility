extends Area2D


var cost = 10
var type = "ConveyorMerger"

var holding
var conveyorRotation = 'north' #sourcePos
var maxArrayIndex
var currentPosY
var currentPosX
var nextTarget = 0

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouseOver = false
var clickL = false
var clickR = false
var restNodePos

var absoluteNorthY
var absoluteNorthX
var absoluteEastY
var absoluteEastX
var absoluteSouthY
var absoluteSouthX
var absoluteWestY
var absoluteWestX

# signal conveyor_invalid_target_or_source(currentPosY, currentPosX)
# signal conveyor_target_busy(currentPosY, currentPosX)


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

func split():
	var targetPosX = []
	var targetPosY = []
	targetPosX.resize(3)
	targetPosY.resize(3)
	get_nearby_absolute_position()	
	match conveyorRotation:
		'north':
			targetPosY[0] = absoluteEastY
			targetPosX[0] = absoluteEastX
			targetPosY[1] = absoluteSouthY
			targetPosX[1] = absoluteSouthX
			targetPosY[2] = absoluteWestY
			targetPosX[2] = absoluteWestX
		'east':
			targetPosY[0] = absoluteSouthY
			targetPosX[0] = absoluteSouthX
			targetPosY[1] = absoluteWestY
			targetPosX[1] = absoluteWestX
			targetPosY[2] = absoluteNorthY
			targetPosX[2] = absoluteNorthX
		'south':
			targetPosY[0] = absoluteWestY
			targetPosX[0] = absoluteWestX
			targetPosY[1] = absoluteNorthY
			targetPosX[1] = absoluteNorthX
			targetPosY[2] = absoluteEastY
			targetPosX[2] = absoluteEastX
		'west':
			targetPosY[0] = absoluteNorthY
			targetPosX[0] = absoluteNorthX
			targetPosY[1] = absoluteEastY
			targetPosX[1] = absoluteEastX
			targetPosY[2] = absoluteSouthY
			targetPosX[2] = absoluteSouthX
	
	var target = []
	target.resize(3)
	
	target[0] = get_conveyor_from_pos(targetPosY[0], targetPosX[0])
	target[1] = get_conveyor_from_pos(targetPosY[1], targetPosX[1])
	target[2] = get_conveyor_from_pos(targetPosY[2], targetPosX[2])

	if (target[nextTarget] != null):
		target[nextTarget].holding = holding
		holding = null
		increment_next_target()
	else:
		increment_next_target()
		split()

func get_nearby_absolute_position():
	absoluteNorthY = currentPosY - 1
	absoluteNorthX = currentPosX

	absoluteEastY = currentPosY
	absoluteEastX = currentPosX + 1

	absoluteSouthY = currentPosY
	absoluteSouthX = currentPosX + 1
	
	absoluteWestY = currentPosY
	absoluteWestX = currentPosX - 1

func check_legal_pos(posY, posX):
	if (posY >= 0) and (posX >= 0) and (posY <= Global.gridColumn) and (posX <= Global.gridRows):
		return true
	else:
		return false

func get_node_from_pos(posY, posX):
	if (check_legal_pos(posY, posX) == false):
		return null
	elif (Global.restNodesGridPos[posY][posX] != null):
		return Global.restNodesGridPos[posY][posX]

func get_conveyor_from_pos(posY, posX):
	var node = get_node_from_pos(posY, posX)
	if (node == null):
		return null
	elif (node.type == 'ConveyorCCW') or (node.type == 'ConveyorCW') or (node.type == 'ConveyorStraight'):
		return node
	else:
		return null

func increment_next_target():
	nextTarget += 1
	if (nextTarget == 3):
		nextTarget = 0