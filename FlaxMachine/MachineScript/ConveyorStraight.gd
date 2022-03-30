extends Area2D

var cost = 5
var type = "ConveyorStraight"

var holding
var conveyorRotation = 'north'
var maxArrayIndex
var currentPosY
var currentPosX
var bought = false

var shortestDist = 60 
var defaultNode = 0
var currentNode
var mouseOver = false
var clickL = false
var clickR = false
var restNodePos
var outOfMoney = false

var absoluteNorthY
var absoluteNorthX
var absoluteEastY
var absoluteEastX
var absoluteSouthY
var absoluteSouthX
var absoluteWestY
var absoluteWestX

signal conveyor_invalid_target_or_source(currentPosY, currentPosX)
signal conveyor_target_busy(currentPosY, currentPosX)


func _ready():
	maxArrayIndex = ((Global.gridColumn * 10) + Global.gridRows) + 1

func _process(delta):
	if (clickL == true):
		global_position = get_global_mouse_position()
	else:
		global_position = lerp(global_position, restNodePos, 10 * delta)

func _on_ConveyorStraight_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if (event is InputEventMouseButton):
		print(self)
		# print(event)
		# print(event.button_index)
		# print(event.pressed)
		if (Global.money >= cost):
			outOfMoney = false
			if (event.pressed == true):
				if (event.button_index == BUTTON_LEFT):
					# print('L just pressed')
					clickL = true
					emit_signal("mouse_down")
				elif (event.button_index == BUTTON_RIGHT):
					# print('R just pressed')
					clickR = true
					rotate_conveyor()
			elif (event.pressed == false):
				# print(event.button_index)
				if (event.button_index == BUTTON_LEFT):
					# print('L just not pressed')
					clickL = false
					clickR = false
					emit_signal("mouse_up")
					snap_to_nearest_rest_node()
				elif (event.button_index == BUTTON_RIGHT):
					# print('R just not pressed')
					clickR = false

			get_tree().set_input_as_handled()
	
		else:
			outOfMoney = true
			if (event.button_index == BUTTON_LEFT) and (event.pressed == true):
				emit_signal("out_of_money", type)

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
	if currentNode:
		currentNode.selected = false
	if restNode.is_in_group('restZonesGrid'):
		bought = true
	restNode.machine = self
	restNode.select()
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
	
	# print(conveyorRotation)
	# print(self.rotation_degrees)
	self.rotation_degrees += 90
#	self.rotation = lerp_angle(self.rotation, rotationsRadian[newRotationsIndex], 200)
	# print(self.rotation_degrees)

func move_items():
	if bought == false:
		return

	if holding != null:
		return

	# print('move triggered =======', self, holding)
	var targetPosY
	var targetPosX
	var sourcePosY
	var sourcePosX
	get_nearby_absolute_position()
	
	match conveyorRotation:
		'north':
			targetPosY = absoluteNorthY
			targetPosX = absoluteNorthX
			sourcePosY = absoluteSouthY
			sourcePosX = absoluteSouthX
		'east':
			targetPosY = absoluteEastY
			targetPosX = absoluteEastX
			sourcePosY = absoluteWestY
			sourcePosX = absoluteWestX
		'south':
			targetPosY = absoluteSouthY
			targetPosX = absoluteSouthX
			sourcePosY = absoluteNorthY
			sourcePosX = absoluteNorthX
		'west':
			targetPosY = absoluteWestY
			targetPosX = absoluteWestX
			sourcePosY = absoluteEastY
			sourcePosX = absoluteEastX
	
	var isLegalPos = []
	isLegalPos.append(check_legal_pos(sourcePosY, sourcePosX))
	isLegalPos.append(check_legal_pos(targetPosY, targetPosX))

	if isLegalPos.has(false):
		emit_signal('conveyor_invalid_target_or_source', currentPosY, currentPosX)
		return
	
	var source = get_node_from_pos(sourcePosY, sourcePosX)
	var target = get_node_from_pos(targetPosY, targetPosX)

	if source:
		# print(source)
		if (source.type.begins_with('Conveyor')):
			print('source conveyor route', self, source, source.holding, holding)
			source.remove_child_in_HoldingContainer()
			holding = source.holding
			source.holding = null
		
		elif (source.type == 'Warehouse'):
			# print('warehouse route')
			if (source.interfaceMode == 'out') and (source.stock > 0):
				holding = source.stockTemplatePacked.instance()
				source.stock -= 1

		elif (source.output != null):
			# print('normal route')
			# print('source.output != null')
			holding = source.output
			source.output = null
			get_node("HoldingLabel").text = holding


		if target:
			# print(target.type)
			# print(target.type.begins_with('Conveyor'))
			if (target.type.begins_with('Conveyor')):
				pass
			# 	print('target conveyor route', self)
			# 	target.holding = holding
			# 	holding = null
			# 	if (target.type == 'ConveyorMerger'):
			# 		target.merge()

			elif (target.type == 'Warehouse'):
				# print('warehouse route')
				if (source.interfaceMode == 'in'):
					source.stock += 1

			elif (target.input == null):
				# print('normal route')
				# print('target.input ==null')
				target.input = holding
				holding = null
				get_node("HoldingLabel").text = 'text'

			# return true
		else:
			emit_signal('conveyor_target_busy', currentPosY, currentPosX)
			# return false
	
	print(holding)		
	display_holding()
		
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
		return Global.restNodesGridPos[posY][posX].machine

func get_conveyor_from_pos(posY, posX):
	var node = get_node_from_pos(posY, posX)
	if (node == null):
		return null
	elif (node.type == 'ConveyorCCW') or (node.type == 'ConveyorCW') or (node.type == 'ConveyorStraight'):
		return node
	else:
		return null

func display_holding():
	# print('holding triggered')
	if holding != null:
		# print('holding not null')
		# for child in get_tree().get_nodes_in_group('holding'):
		# 	child.queue_free()

		get_node('HoldingContainer').add_child(holding)
		holding.add_to_group('holding')

func remove_child_in_HoldingContainer():
	for child in get_node('HoldingContainer').get_children():
		# print('removing', child)
		get_node('HoldingContainer').remove_child(child)
