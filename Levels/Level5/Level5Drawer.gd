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
	
	var drawerColumn = 2 # start counting at 0
	var drawerRows = 1 # start counting at 0
	
	drawerNodesPos = generate_pos_array(drawerRows, drawerColumn, Global.allRestNodesDrawer)
#	assign_default_node()
	
	spawn_machine(MachineLoom, drawerNodesPos[defaultLoomPosY][defaultLoomPosX], false)
	spawn_machine(MachineSewing, drawerNodesPos[defaultSewingPosY][defaultSewingPosX], false)
	spawn_machine(MachineDyeing, drawerNodesPos[defaultDyeingPosY][defaultDyeingPosX], false)
	spawn_machine(MachinePackager, drawerNodesPos[defaultPackagerPosY][defaultPackagerPosX], false)

	connect_nodes(get_tree().root)
	get_tree().connect("node_added", self, "_on_SceneTree_node_added")

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
	
	return array

func spawn_machine(machine, restNode, reduceMoney):
	var newMachine = machine.instance()
	var machineCost = newMachine.cost
	var machineType = newMachine.type
	var containerName = 'Container' + machineType
	# print(containerName)
	# print(get_node(containerName))
	# var defaultNode = drawerNodesPos[defaultLoomPos]
	if reduceMoney == true:
		var moneyOpsSuccessful = money_ops(machineCost)
		if moneyOpsSuccessful == false:
			newMachine.queue_free()
			pass
	get_node(containerName).add_child(newMachine)
	add_to_group(machineType)
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

# automatically add button sounds from https://gamedev.stackexchange.com/questions/184354/add-a-sound-to-all-the-buttons-in-a-project
func _on_SceneTree_node_added(node):
	if node is Area2D:
		connect_to_node(node)

func _on_mouse_down():
	get_node('SoundDropPlayer').play()

func _on_mouse_up():
	get_node('SoundPickPlayer').play()

func _on_out_of_money(type):
	var text = "Out of money on buying " + type
	print(get_parent())
	get_parent().hud.display_warning(text)

# recursively connect all nodes
func connect_nodes(root):
	for child in root.get_children():
		if child is Area2D:
			connect_to_node(child)
		connect_nodes(child)

func connect_to_node(node):
	node.connect("mouse_down", self, "_on_mouse_down")
	node.connect("mouse_up", self, "_on_mouse_up")
	node.connect("out_of_money", self, "_on_out_of_money")
