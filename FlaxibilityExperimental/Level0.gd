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
var gridID = []
var gridX = 2
var gridY = 2
onready var drawer = get_node("Level0Drawer")
onready var grid = get_node("Level0Grid")
onready var gridID_Back = get_node("Level0Drawer/GridMachine")

#onready var timer = get_node("Timer")


func _ready():
#	print('restzonesgroup = ', get_tree().get_nodes_in_group('restZones'))
	Global.money = money
	Global.cotton = cotton
	Global.color = color
	grid()
	Global.gridID = gridID

func _on_RunButton_pressed():
	#pause and play
	if RunButton == true:
		RunButton = false
	else:
		RunButton = true
	#transfer system
	while (cotton > 0) and (RunButton == true):
		if cotton >= 1:
			cotton = cotton - 1
			gridID_Back.get_node("CollisionShape00").cotton += 1 
			yield(get_tree().create_timer(0.2),"timeout")
		else:
			break
	while (thread > 0) and (RunButton == true):
		if thread >= 1:
			thread = thread - 1
			gridID_Back.get_node("CollisionShape00").thread += 1 
			yield(get_tree().create_timer(0.2),"timeout")
		else:
			break
	while (fabric > 0) and (RunButton == true):
		if fabric >= 1:
			fabric = fabric - 1
			gridID_Back.get_node("CollisionShape00").fabric += 1 
			yield(get_tree().create_timer(0.2),"timeout")
		else:
			break
	while (color_fabric > 0) and (RunButton == true):
		if color_fabric >= 1:
			color_fabric = color_fabric - 1
			gridID_Back.get_node("CollisionShape00").color_fabric += 1 
			yield(get_tree().create_timer(0.2),"timeout")
		else:
			break
			

			

		
func updateMachine_pos():
	#Loom machine update
	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[00]]: #and grid[0]!= 1:
		gridID[0] = 0
	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[01]]: #and grid[1]!= 1:
		gridID[1] = 0
	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[10]]: #and grid[2]!= 1:
		gridID[2] = 0
	if drawer.get_node("MachineLoom").currentNode == grid.restNodesGrid[grid.restNodesPos[11]]: #and grid[3]!= 1:
		gridID[3] = 0
	#dyeing machine update
	if drawer.get_node("MachineDyeing").currentNode == grid.restNodesGrid[grid.restNodesPos[00]]: #and grid[0]!= 1 :
		gridID[0] = 1
	if drawer.get_node("MachineDyeing").currentNode == grid.restNodesGrid[grid.restNodesPos[01]]: #and grid[1]!= 1:
		gridID[1] = 1
	if drawer.get_node("MachineDyeing").currentNode == grid.restNodesGrid[grid.restNodesPos[10]]: #and grid[2]!= 1:
		gridID[2] = 1
	if drawer.get_node("MachineDyeing").currentNode == grid.restNodesGrid[grid.restNodesPos[11]]: #and grid[3]!= 1:
		gridID[3] = 1
	Global.gridID = gridID
	print(gridID)
		
		
		
func _on_Timer_timeout():
	updateMachine_pos()
	updateResource()

func updateResource():
	Global.cotton = cotton +gridID_Back.get_node("CollisionShape00").cotton + gridID_Back.get_node("CollisionShape01").cotton + gridID_Back.get_node("CollisionShape10").cotton + gridID_Back.get_node("CollisionShape11").cotton
	Global.fabric = fabric + gridID_Back.get_node("CollisionShape00").fabric + gridID_Back.get_node("CollisionShape01").fabric + gridID_Back.get_node("CollisionShape10").fabric + gridID_Back.get_node("CollisionShape11").fabric
	Global.color_fabric = color_fabric + gridID_Back.get_node("CollisionShape00").color_fabric + gridID_Back.get_node("CollisionShape01").color_fabric + gridID_Back.get_node("CollisionShape10").color_fabric + gridID_Back.get_node("CollisionShape11").color_fabric
	
func grid():
	var maxgrid = int(gridX*gridY)
	gridID.resize(maxgrid)
#	print ("maxgrid : "+str(maxgrid))



