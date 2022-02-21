extends Control


var drawerNodesPos = []
#var allRestNodesDrawer = [] #moved to Global.allRestNodesDrawer

var MachineLoom = preload('res://FlaxMachine/Loom.tscn')
var MachineSewing = preload('res://FlaxMachine/Packager.tscn')
var MachineDyeing = preload('res://FlaxMachine/Dyeing.tscn')
var MachinePackager = preload('res://FlaxMachine/Packager.tscn')

var defaultLoomPos = 00
var defaultSewingPos = 01
var defaultDyeingPos = 10
var defaultPackagerPos = 11

func _ready():
	var drawerColumn = 1 # start counting at 0
	var drawerRows = 1 # start counting at 0
	
	generate_pos_array(drawerColumn, drawerRows)
#	assign_default_node()
	
#	spawn_machine(MachineLoom)

func _process(delta):
	spawn_machine_when_rest_node_is_empty(MachineLoom, defaultLoomPos)
#	spawn_machine_when_rest_node_is_empty(MachineSewing, defaultSewingPos)
#	spawn_machine_when_rest_node_is_empty(MachineDyeing, defaultDyeingPos)
#	spawn_machine_when_rest_node_is_empty(MachinePackager, defaultPackagerPos)

func generate_pos_array(drawerColumn, drawerRows):
	var currentColumn = 0
	var currentRow  = 0
	var arrayIndex
	var currentChild = 0
	
	var maxArrayIndex = int(String(drawerColumn) + String(drawerRows)) + 1
	drawerNodesPos.resize(maxArrayIndex)
	
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

func spawn_machine(machineName):
	var containerName = 'Container'
	var newMachine = machineName.instance()
	var defaultNode = drawerNodesPos[defaultLoomPos]
#	print(defaultNode)
	get_node(containerName).add_child(newMachine)
	newMachine.snap_to(defaultNode)

func spawn_machine_when_rest_node_is_empty(machineName, defaultMachinePos):
	var restNode = drawerNodesPos[defaultMachinePos]
	if restNode.selected == false:
		spawn_machine(machineName)
