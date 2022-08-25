extends Control



var restNodesPos
var mission = 0  
var money = 120
var color = 5
var thread = 30
var fabric = 0
var shirt = 0
var color_shirt = 0
var RunButton = false
var delay = 0
var i = 2
onready var drawer = get_node("Level3Drawer")
onready var grid = get_node("Level3Grid")
onready var hud = get_node("Level3HUD")
onready var gridID_Back = get_node("Level3Drawer/GridMachine")


# Called when the node enters the scene tree for the first time.
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
	Global.color_shirt = color_shirt
	Global.mission = mission
	

	Global.RunButton = false
	
	Global.allRestNodes = get_tree().get_nodes_in_group('restZone')
	print(Global.allRestNodes)


func _process(delta):
	if(Global.RunButton == true):
		if(Global.restNodesGridPos[2][1].selected == true)and Global.restNodesGridPos[2][1].machine.type == 'Sewing':
			while(Global.thread >= 5):
				Global.thread = Global.thread - 5
				Global.fabric = Global.fabric+1
		if(Global.restNodesGridPos[4][1].selected == true)and Global.restNodesGridPos[4][1].machine.type == 'Sewing':
			while(Global.fabric >= 3):
				Global.fabric = Global.fabric - 3
				Global.shirt = Global.shirt + 1
		if(Global.restNodesGridPos[5][5].selected == true)and Global.restNodesGridPos[5][5].machine.type == 'Dyeing':
			while(Global.shirt >= 1 and Global.color >= 1):
				Global.shirt = Global.shirt - 1
				Global.color = Global.color - 1
				Global.color_shirt = Global.color_shirt + 1
		if(Global.color_shirt == 2):
			mission = 1
			Global.mission = mission
