extends Node2D


var restNodesPos 
var money = 100
var color = 5
var cotton = 100
var thread = 0
var fabric = 0
var color_fabric = 0
var RunButton = false
var delay = 0
var i = 2
onready var drawer = get_node("Level0Drawer")
onready var grid = get_node("Level0Grid")
onready var gridID_Back = get_node("Level0Drawer/GridMachine")

#onready var timer = get_node("Timer")


func _ready():
#	print('restzonesgroup = ', get_tree().get_nodes_in_group('restZones'))
	Global.money = money
	Global.cotton = cotton
	Global.color = color
	
	Global.allRestNodes = get_tree().get_nodes_in_group('restZones')
	
#	drawer.get_node('Container').get_node('MachineLoom1').snap_to_from_index(0)
#	drawer.get_node('Container').get_node('MachineLoom1').get_node("Label").text = '1: input'
#	drawer.get_node('Container').get_node('MachineLoom2').snap_to_from_index(1)
#	drawer.get_node('Container').get_node('MachineLoom2').get_node("Label").text = '2: output'
#	drawer.get_node('Container').get_node('ConveyorCW').snap_to_from_index(2)

func _on_RunButton_pressed():
	#pause and play
	print(Global.allRestNodes[0].machine.type)
	if RunButton == true:
		RunButton = false
		Global.RunButton = RunButton
	else:
		RunButton = true
		Global.RunButton = RunButton
		TransferItem()
		gamecheck()

func gameClear():
	get_node("LevelCompletedPopup").visible = true
	get_node("LevelCompletedPopup/LevelCompletedText").visible_characters = -1
#
func TransferItem():
	if cotton > 0 or thread > 0 or fabric > 0 or color_fabric > 0 and RunButton == true:
		while cotton > 0:
			cotton = cotton - 1
			$Level0Grid/GridMachine/CollisionShape00.cotton = cotton
			yield(get_tree().create_timer(0.25),"timeout")
		while thread > 0:
			thread = thread - 1
			$Level0Grid/GridMachine/CollisionShape00.thread = thread
			yield(get_tree().create_timer(0.25),"timeout")
		while fabric > 0:
			fabric = fabric - 1
			$Level0Grid/GridMachine/CollisionShape00.fabric = fabric
			yield(get_tree().create_timer(0.25),"timeout")
		while color_fabric > 0:
			color_fabric = color_fabric - 1
			$Level0Grid/GridMachine/CollisionShape00.color_fabric = color_fabric
			yield(get_tree().create_timer(0.25),"timeout")
		
	#Loom machine update
	
#	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[01]] and gridID[1] == null: 
#		gridID[1] = 0
#	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[10]] and gridID[2] == null:
#		gridID[2] = 0
#	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[11]] and gridID[3] == null: 
#		gridID[3] = 0
#
#	#dyeing machine update
#	if drawer.get_node("MachineDyeing").currentNode == grid.restNodesGrid[grid.restNodesPos[00]] and gridID[0] == null: 
#		gridID[0] = 1
#	if drawer.get_node("MachineDyeing").currentNode == grid.restNodesGrid[grid.restNodesPos[01]] and gridID[1] == null: 
#		gridID[1] = 1
#	if drawer.get_node("MachineDyeing").currentNode == grid.restNodesGrid[grid.restNodesPos[10]] and gridID[2] == null: 
#		gridID[2] = 1
#	if drawer.get_node("MachineDyeing").currentNode == grid.restNodesGrid[grid.restNodesPos[11]] and gridID[3] == null: 
#		gridID[3] = 1
#	Global.gridID = gridID
#	print(gridID)

		
		
func updateResource():
	if RunButton == true:
		Global.cotton = $Level0Grid/GridMachine/CollisionShape00.cotton + $Level0Grid/GridMachine/CollisionShape01.cotton + $Level0Grid/GridMachine/CollisionShape10.cotton + $Level0Grid/GridMachine/CollisionShape11.cotton
		Global.thread = $Level0Grid/GridMachine/CollisionShape00.thread + $Level0Grid/GridMachine/CollisionShape01.thread + $Level0Grid/GridMachine/CollisionShape10.thread + $Level0Grid/GridMachine/CollisionShape11.thread
		Global.fabric = $Level0Grid/GridMachine/CollisionShape00.fabric + $Level0Grid/GridMachine/CollisionShape01.fabric + $Level0Grid/GridMachine/CollisionShape10.fabric + $Level0Grid/GridMachine/CollisionShape11.fabric
		Global.color_fabric = $Level0Grid/GridMachine/CollisionShape00.color_fabric + $Level0Grid/GridMachine/CollisionShape01.color_fabric + $Level0Grid/GridMachine/CollisionShape10.color_fabric + $Level0Grid/GridMachine/CollisionShape11.color_fabric
		Global.cotton = $Level0Grid/GridMachine/CollisionShape00.cotton + $Level0Grid/GridMachine/CollisionShape01.cotton + $Level0Grid/GridMachine/CollisionShape10.cotton + $Level0Grid/GridMachine/CollisionShape11.cotton
		Global.cotton = $Level0Grid/GridMachine/CollisionShape00.cotton + $Level0Grid/GridMachine/CollisionShape01.cotton + $Level0Grid/GridMachine/CollisionShape10.cotton + $Level0Grid/GridMachine/CollisionShape11.cotton

func _process(delta):
	updateResource()

func gamecheck():	
	#print("0 :"+str(Global.allRestNodesGrid[0].machine.type))
	#print("1 :"+str(Global.allRestNodesGrid[1].machine.type))
	#print("2 :"+str(Global.allRestNodesGrid[2].machine.type))
	#print("3 :"+str(Global.allRestNodesGrid[3].machine.type))
	if (Global.allRestNodesGrid[0].machine.type == "Loom"):
		if (Global.allRestNodesGrid[1].machine.type == "Sewing") or (Global.allRestNodesGrid[2].machine.type == "Sewing"):
			if(Global.allRestNodesGrid[3].machine.type == "Dyeing"):
				print("level complete")
			else:
				print("level fail")
		else:
			print("level fail")
	else:
		print("level fail")
#For Demo in slides
#func _process(_delta):
#	print(drawer.get_node("MachineLoom").clicked)
#	if (drawer.get_node("MachineDyeing").clicked == true) or (drawer.get_node("MachineLoom").clicked == true) or (drawer.get_node("MachineSewing").clicked == true) or (drawer.get_node("MachinePackager").clicked == true):
#		get_node('MouseStatusForDemo').text = '↓ Mouse down ↓'
#	else:
#		get_node('MouseStatusForDemo').text = '↑ Mouse up ↑'

#func _on_ConveyorButton_pressed():
#	drawer.get_node('Container').get_node('MachineLoom1').output = 'item'
#	print(drawer.get_node('Container').get_node('MachineLoom1').output)
#	print(drawer.get_node('Container').get_node('ConveyorCW').holding)
#	print(drawer.get_node('Container').get_node('MachineLoom2').input)
#
#	drawer.get_node('Container').get_node('ConveyorCW').conveyorRotation = 'east'
#	print(drawer.get_node('Container').get_node('ConveyorCW').move_items())
#
#	print(drawer.get_node('Container').get_node('MachineLoom1').output)
#	print(drawer.get_node('Container').get_node('ConveyorCW').holding)
#	print(drawer.get_node('Container').get_node('MachineLoom2').input)
