extends Control



var restNodesPos 
var mission = 0
var money = 200
var color = 1500
var thread = 15000
var fabric = 0
var color_fabric = 0
var shirt = 0
var RunButton = false
var delay = 0
var i = 2
onready var drawer = get_node("Level6Drawer")
onready var grid = get_node("Level6Grid")
onready var hud = get_node("Level6HUD")
onready var gridID_Back = get_node("Level6Drawer/GridMachine")

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
	Global.color_fabric = color_fabric
	Global.shirt = shirt
	Global.mission = mission

	Global.RunButton = false
	
	Global.allRestNodes = get_tree().get_nodes_in_group('restZone')

func _process(delta):
	if(Global.RunButton == true):
		if(Global.restNodesGridPos[1][1].selected == true):
			while(Global.thread >= 5):
				Global.thread = Global.thread - 5
				Global.fabric = Global.fabric+1
		if(Global.restNodesGridPos[2][2].selected == true):
			while(Global.fabric > 1500):
				Global.fabric = Global.fabric-3
				Global.shirt = Global.shirt+1
		if(Global.restNodesGridPos[1][3].selected == true):
			while(Global.fabric >= 1 and Global.color >= 1):
				Global.fabric = Global.fabric-1
				Global.color = Global.color-1
				Global.color_fabric = Global.color_fabric+1
		if(Global.restNodesGridPos[2][4].selected == true):
			while(Global.shirt >= 100 or Global.color_fabric >= 100):
				if(Global.color_fabric >= 100):
					Global.color_fabric = Global.color_fabric-100
					Global.pack_color_fabric = Global.pack_color_fabric+1
				if(Global.shirt >= 100):
					Global.shirt = Global.shirt-100
					Global.pack_shirt = Global.pack_shirt+1
		if(Global.pack_shirt == 5 and Global.pack_color_fabric == 15):
			mission = 1
			Global.mission = mission
