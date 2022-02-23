extends Control


var drawerNodesPos = []
var maxArrayIndex
var outOfMoney = false
#var allRestNodesDrawer = [] #moved to Global.allRestNodesDrawer

var MachineLoom = preload('res://FlaxMachine/Loom.tscn')
var MachineSewing = preload('res://FlaxMachine/Packager.tscn')
var ConveyorStraight = preload('res://FlaxMachine/ConveyorStraight.tscn')
var ConveyorCW = preload('res://FlaxMachine/ConveyorCW.tscn')
var MachineDyeing = preload('res://FlaxMachine/Dyeing.tscn')
var MachinePackager = preload('res://FlaxMachine/Packager.tscn')

var defaultLoomPos = 00
var defaultSewingPos = 01
var defaultConveyorStraightPos = 00
var defaultDyeingPos = 10
var defaultPackagerPos = 11

func _ready():
	Global.allRestNodesDrawer = get_tree().get_nodes_in_group('restZonesDrawer')
	
	var drawerColumn = 1 # start counting at 0
	var drawerRows = 1 # start counting at 0
	
	generate_pos_array(drawerColumn, drawerRows)
#	assign_default_node()
	
#	spawn_machine(MachineLoom, drawerNodesPos[defaultLoomPos], false)
#	spawn_machine(ConveyorCW, drawerNodesPos[01], false)

func _process(delta):
	spawn_machine_when_rest_node_is_empty(MachineLoom, defaultLoomPos)
#	spawn_machine_when_rest_node_is_empty(ConveyorStraight, defaultConveyorStraightPos)
#	spawn_machine_when_rest_node_is_empty(MachineSewing, defaultSewingPos)
#	spawn_machine_when_rest_node_is_empty(MachineDyeing, defaultDyeingPos)
#	spawn_machine_when_rest_node_is_empty(MsachinePackager, defaultPackagerPos)
#	pass

func generate_pos_array(drawerColumn, drawerRows):
	var currentColumn = 0
	var currentRow  = 0
	var arrayIndex
	var currentChild = 0
	
	var maxArrayIndex = (drawerColumn * 10) + drawerRows
	drawerNodesPos.resize(maxArrayIndex + 1)
	
	for child in Global.allRestNodesDrawer:
#	for child in get_ch
#		print('child = ', child, 'currentChild = ', currentChild)
		# print(get_tree().get_nodes_in_group('restZones'))
		if currentRow > drawerRows:
#			print('currentRow = ', currentRow)
			currentRow = 0
			currentColumn += 1
		arrayIndex = int(String(currentColumn) + String(currentRow))
#		print('arrayindex = ', arrayIndex)
		drawerNodesPos[arrayIndex] = child
#		print(drawerNodesPos[arrayIndex])
		currentChild += 1
		currentRow += 1

#func assign_default_node():
#	$MachineLoom.defaultNode = drawerNodesPos[defaultLoomPos]
#	$MachineSewing.defaultNode = drawerNodesPos[defaultSewingPos]
#	$MachineDyeing.defaultNode = drawerNodesPos[defaultDyeingPos]
#	$MachinePackager.defaultNode = drawerNodesPos[defaultPackagerPos]

func spawn_machine(machine, restNode, reduceMoney):
	var containerName = 'Container'
	var newMachine = machine.instance()
	var machineCost = newMachine.cost
	var defaultNode = drawerNodesPos[defaultLoomPos]
	if reduceMoney ==true:
		var moneyOpsSuccessful = money_ops(machineCost)
		if moneyOpsSuccessful == true :
			get_node(containerName).add_child(newMachine)
			newMachine.snap_to(defaultNode)
			if newMachine.type == 'Conveyor':
				newMachine.maxArrayIndex = maxArrayIndex
		else:
			outOfMoney = true
			newMachine.queue_free()


func spawn_machine_when_rest_node_is_empty(machine, defaultMachinePos):
	var restNode = drawerNodesPos[defaultMachinePos]
#	print(restNode.selected)
	if restNode.selected == false and outOfMoney == false:
		spawn_machine(machine, restNode, true)

func money_ops(amount):
	if amount >= Global.money:
		Global.money - amount
		return true
	else:
		return false
