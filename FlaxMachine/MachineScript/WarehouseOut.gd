extends Area2D


var type = 'Warehouse'

var stock: int
var stockTemplate: Object
var holding
var interfaceRotation = 'south'
var interfaceMode = 'out'
var maxArrayIndex
var currentPosY
var currentPosX

var mouseOver = false
var clickL = false
var clickR = false
var restNodePos


func _ready():
	maxArrayIndex = ((Global.gridColumn * 10) + Global.gridRows) + 1
	apply_rotation(interfaceRotation)

# func _process(_delta):
# 	pass

func apply_rotation(rotationName):
	var rotationsDirections = ['north', 'east', 'south', 'west']
	var rotationDegrees = [180, 270, 0, 90]
	var newRotationsIndex = rotationsDirections.find(rotationName)
	var newRotationsDegree = rotationDegrees[newRotationsIndex]
	
	get_node('Arrow').rotation_degrees = newRotationsDegree

# func move_items():
# 	var targetPosY
# 	var targetPosX
# 	match interfaceRotation:
# 		'north':
# 			targetPosY = currentPosY - 1
# 			targetPosX = currentPosX
# 		'east':
# 			targetPosY = currentPosY
# 			targetPosX = currentPosX + 1
# 		'south':
# 			targetPosY = currentPosY + 1
# 			targetPosX = currentPosX
# 		'west':
# 			targetPosY = currentPosY
# 			targetPosX = currentPosX - 1
	
# 	if not (targetPosY >= 0) and not (targetPosX >= 0) and not (targetPosY <= Global.gridColumn) and not (targetPosX <= Global.gridRows):
# 		emit_signal('conveyor_invalid_target_or_source', currentPosY, currentPosX)
# 		pass
	
# 	var target = Global.restNodesGridPos[targetPosY][targetPosX].machine
# 	print('target', target, target.input)

# 	if (target == false):
# 		emit_signal('conveyor_invalid_target_or_source', currentPosY, currentPosX)
# 		pass

# 	if target and (target.input == null) and (holding == null):
# 		get_node("HoldingLabel").text = holding
# 			# todo: play anim
# 		yield(get_tree().create_timer(0.5), "timeout")
# 		target.input = holding
# 		holding = null
# 		get_node("HoldingLabel").text = 'text'
# 		return true
# 	else:
# 		emit_signal('conveyor_target_busy', currentPosY, currentPosX)
# 		return false