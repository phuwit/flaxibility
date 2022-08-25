extends Control



var restNodesPos 
var mission = 0
var money = 120
var color = 20
var thread = 150
var fabric = 0
var shirt = 0
var color_fabric = 0
var color_shirt = 0
var RunButton = false
var delay = 0
var i = 2
onready var drawer = get_node("Level4Drawer")
onready var grid = get_node("Level4Grid")
onready var hud = get_node("Level4HUD")
onready var gridID_Back = get_node("Level4Drawer/GridMachine")

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
	Global.color_shirt = color_shirt
	Global.mission = mission

	Global.RunButton = false
	
	Global.allRestNodes = get_tree().get_nodes_in_group('restZone')
func _process(delta):
		if(Global.RunButton == true):
			if(Global.restNodesGridPos[1][4].selected == true)and Global.restNodesGridPos[1][4].machine.type == 'Sewing':
				while(Global.thread >= 5):
					Global.thread = Global.thread - 5
					Global.fabric = Global.fabric + 1
			if(Global.restNodesGridPos[2][5].selected == true)and Global.restNodesGridPos[2][5].machine.type == 'Sewing':
				while(Global.fabric > 15):
					Global.fabric = Global.fabric - 3
					Global.shirt = Global.shirt+1
			if(Global.restNodesGridPos[1][6].selected == true)and Global.restNodesGridPos[1][6].machine.type == 'Dyeing':
				while(Global.fabric >= 1 and Global.color >= 1):
					Global.fabric = Global.fabric - 1
					Global.color = Global.color - 1
					Global.color_fabric = Global.color_fabric+1
				while(Global.shirt >= 1 and Global.color >= 1):
					Global.shirt = Global.shirt-1
					Global.color = Global.color-1
					Global.color_shirt = Global.color_shirt+1
			if(Global.color_fabric == 15 and Global.color_shirt == 5):
				mission = 1
				Global.mission = mission

