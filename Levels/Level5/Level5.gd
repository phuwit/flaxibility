extends Control



var restNodesPos 
var mission = 0
var money = 120
var color = 30
var thread = 405
var fabric = 0
var shirt = 0
var color_fabric = 0
var RunButton = false
var delay = 0
var i = 2
onready var drawer = get_node("Level5Drawer")
onready var grid = get_node("Level5Grid")
onready var hud = get_node("Level5HUD")
onready var gridID_Back = get_node("Level5Drawer/GridMachine")


func reset():
	Global.cotton = 0
	Global.thread = 0
	Global.fabric = 0
	Global.shirt = 0
	Global.color = 0
	Global.color_fabric = 0
	Global.color_shirt = 0
	Global.RunButton = false

func _ready():
	reset()
	Global.money = money
	Global.color = color
	Global.thread = thread
	Global.fabric = fabric
	Global.shirt = shirt
	Global.color_fabric = color_fabric
	Global.mission = mission
	
	Global.RunButton = false
	
	Global.allRestNodes = get_tree().get_nodes_in_group('restZone')

func _process(delta):
	if(Global.RunButton == true):
		if(Global.restNodesGridPos[1][1].selected == true):
			while(Global.thread >= 5):
				Global.thread = Global.thread - 5
				Global.fabric = Global.fabric+1
		if(Global.restNodesGridPos[0][2].selected == true):
			while(Global.fabric > 54 and Global.color >= 1):
				Global.fabric = Global.fabric-1
				Global.color = Global.color-1
				Global.color_fabric = Global.color_fabric+1
		if(Global.restNodesGridPos[2][3].selected == true):
			while(Global.fabric > 27):
				Global.fabric = Global.fabric-3
				Global.shirt = Global.shirt+1
		if(Global.fabric == 27 and Global.color_fabric == 27 and Global.shirt == 9):
				mission = 1
				Global.mission = mission
