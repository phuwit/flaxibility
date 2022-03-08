extends Control


var drawerNodesPos = []
var maxArrayIndex
var outOfMoney = false

var MachineLoom = preload('res://FlaxMachine/Loom.tscn')
var MachineSewing = preload('res://FlaxMachine/Sewing.tscn')
var MachineDyeing = preload('res://FlaxMachine/Dyeing.tscn')
var MachinePackager = preload('res://FlaxMachine/Packager.tscn')

var defaultLoomPos = 00
var defaultSewingPos = 01
var defaultDyeingPos = 10
var defaultPackagerPos = 11

func _ready():
	Global.allRestNodesDrawer = get_tree().get_nodes_in_group('restZonesDrawer')
	
	var drawerColumn = 1 # start counting at 0
	var drawerRows = 1 # start counting at 0
	
	generate_pos_array(drawerColumn, drawerRows)
	
	spawn_machine(MachineLoom, drawerNodesPos[defaultLoomPos], false)
	spawn_machine(MachineSewing, drawerNodesPos[defaultSewingPos], false)
	spawn_machine(MachineDyeing, drawerNodesPos[defaultDyeingPos], false)
	spawn_machine(MachinePackager, drawerNodesPos[defaultPackagerPos], false)

func _process(delta):
	spawn_machine_when_rest_node_is_empty(MachineLoom, defaultLoomPos)
	spawn_machine_when_rest_node_is_empty(MachineSewing, defaultSewingPos)
	spawn_machine_when_rest_node_is_empty(MachineDyeing, defaultDyeingPos)
	spawn_machine_when_rest_node_is_empty(MachinePackager, defaultPackagerPos)

func generate_pos_array(drawerColumn, drawerRows):
	var currentColumn = 0
	var currentRow  = 0
	var arrayIndex
	var currentChild = 0
	
	var maxArrayIndex = (drawerColumn * 10) + drawerRows
	drawerNodesPos.resize(maxArrayIndex + 1)
	
	for child in Global.allRestNodesDrawer:
		if currentRow > drawerRows:
			currentRow = 0
			currentColumn += 1
		arrayIndex = int(String(currentColumn) + String(currentRow))
		drawerNodesPos[arrayIndex] = child
		currentChild += 1
		currentRow += 1

func spawn_machine(machine, restNode, reduceMoney):
	var containerName = 'Container'
	var newMachine = machine.instance()
	var machineCost = newMachine.cost
	if reduceMoney == true:
		var moneyOpsSuccessful = money_ops(machineCost)
		if moneyOpsSuccessful == true:
			get_node(containerName).add_child(newMachine)
			newMachine.snap_to(restNode)
		else:
			outOfMoney = true
			newMachine.queue_free()
	elif reduceMoney == false:
		get_node(containerName).add_child(newMachine)
		newMachine.snap_to(restNode)


func spawn_machine_when_rest_node_is_empty(machine, defaultMachinePos):
	var restNode = drawerNodesPos[defaultMachinePos]
	if restNode.selected == false and outOfMoney == false:
		spawn_machine(machine, restNode, true)

func money_ops(amount):
	if amount >= Global.money:
		Global.money - amount
		return true
	else:
		return false
