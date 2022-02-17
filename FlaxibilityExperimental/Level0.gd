extends Node2D


var restNodesPos 
var money = 100
var cotton = 100
var color = 5
var fabric = 0
var color_fabric = 0
var RunButton = false
var delay = 0
var i = 2
var gridID = []
var gridX = 2
var gridY = 2
onready var drawer = get_node("Level0Drawer")
onready var grid = get_node("Level0Grid")
#onready var timer = get_node("Timer")


func _ready():
#	print('restzonesgroup = ', get_tree().get_nodes_in_group('restZones'))
	Global.money = money
	Global.cotton = cotton
	Global.color = color
	grid()

func _on_RunButton_pressed():
	if RunButton == true:
		RunButton = false
	else:
		RunButton = true
	while (cotton >= 5) and (RunButton == true):
		if cotton >= 5:
			cotton = cotton - 5
			Global.cotton = cotton
			fabric += 1
			Global.fabric = fabric
			yield(get_tree().create_timer(0.2),"timeout")
		else:
			break
	while (fabric >= 1) and (color >= 1) and (RunButton == true):
		if (fabric >= 1) and (color >= 1):
			fabric = fabric - 1
			Global.fabric = fabric
			color = color - 1
			Global.color = color
			color_fabric += 1
			Global.color_fabric = color_fabric
			yield(get_tree().create_timer(0.2),"timeout")
		else:
			break
		
func updateLoom():
	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[00]]:
		gridID[0] = 1
	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[01]]:
		gridID[1] = 1
	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[10]]:
		gridID[2] = 1
	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[11]]:
		gridID[3] = 1
	print(gridID)
		
#func sellerMachine():

func grid():
	var maxgrid = int(gridX*gridY)
	gridID.resize(maxgrid)
#	print ("maxgrid : "+str(maxgrid))
