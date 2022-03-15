extends Control


var drawerNodesPos = []
var maxArrayIndex
#var allRestNodesDrawer = [] #moved to Global.allRestNodesDrawer

var MachineLoom = preload('res://FlaxMachine/Loom.tscn')
var MachineSewing = preload('res://FlaxMachine/Sewing.tscn')
var MachineDyeing = preload('res://FlaxMachine/Dyeing.tscn')
var MachinePackager = preload('res://FlaxMachine/Packager.tscn')

var defaultLoomPosY = 0
var defaultLoomPosX = 0
var defaultSewingPosY = 0
var defaultSewingPosX = 1
var defaultDyeingPosY = 1
var defaultDyeingPosX = 0
var defaultPackagerPosY = 1
var defaultPackagerPosX = 1

func _ready():
	Global.allRestNodesDrawer = get_tree().get_nodes_in_group('restZonesDrawer')
	
	var drawerColumn = 1 # start counting at 0
	var drawerRows = 1 # start counting at 0
	
	drawerNodesPos = generate_pos_array(drawerRows, drawerColumn, Global.allRestNodesDrawer)
#	assign_default_node()
	
	spawn_machine(MachineLoom, drawerNodesPos[defaultLoomPosY][defaultLoomPosX], false)
	spawn_machine(MachineSewing, drawerNodesPos[defaultSewingPosY][defaultSewingPosX], false)
	spawn_machine(MachineDyeing, drawerNodesPos[defaultDyeingPosY][defaultDyeingPosX], false)
	spawn_machine(MachinePackager, drawerNodesPos[defaultPackagerPosY][defaultPackagerPosX], false)

func _process(delta):
	spawn_machine_when_rest_node_is_empty(MachineLoom, defaultLoomPosY, defaultLoomPosX)
	spawn_machine_when_rest_node_is_empty(MachineSewing, defaultSewingPosY, defaultSewingPosX)
	spawn_machine_when_rest_node_is_empty(MachineDyeing, defaultDyeingPosY, defaultDyeingPosX)
	spawn_machine_when_rest_node_is_empty(MachinePackager, defaultPackagerPosY, defaultPackagerPosX)
#	pass

func generate_pos_array(width, height, allNodes):
	var array = []
	var currentIndex = 0
	width += 1
	height += 1
	
	for y in range(height):
		array.append([])
		array[y].resize(width)
	
		for x in range(width):
			print(allNodes)
			array[y][x] = allNodes[currentIndex]
			currentIndex += 1
	
#	print(array)
	return array

#func assign_default_node():
#	$MachineLoom.defaultNode = drawerNodesPos[defaultLoomPos]
#	$MachineSewing.defaultNode = drawerNodesPos[defaultSewingPos]
#	$MachineDyeing.defaultNode = drawerNodesPos[defaultDyeingPos]
#	$MachinePackager.defaultNode = drawerNodesPos[defaultPackagerPos]

func spawn_machine(machine, restNode, reduceMoney):
	var newMachine = machine.instance()
	var machineCost = newMachine.cost
	var containerName = 'Container' + newMachine.type
	print(containerName)
	print(get_node(containerName))
#	var defaultNode = drawerNodesPos[defaultLoomPos]
	if reduceMoney == true:
		var moneyOpsSuccessful = money_ops(machineCost)
		if moneyOpsSuccessful == true:
			print(newMachine)
			get_node(containerName).add_child(newMachine)
			newMachine.snap_to(restNode)
		else:
			newMachine.queue_free()
	elif reduceMoney == false:
		get_node(containerName).add_child(newMachine)
		newMachine.snap_to(restNode)


func spawn_machine_when_rest_node_is_empty(machine, defaultMachinePosY, defaultMachinePosX):
	var restNode = drawerNodesPos[defaultMachinePosY][defaultMachinePosX]
#	print(restNode.selected)
	if restNode.selected == false:
#		print(restNode)
		spawn_machine(machine, restNode, true)

func money_ops(amount):
#	print(amount, Global.money)
	if amount <= Global.money:
		Global.money -= amount
		return true
	else:
		return false
