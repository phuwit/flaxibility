extends Control



var restNodesPos
var mission = 0 
var money = 120
var color = 3
var cotton = 80
var thread = 0
var fabric = 0
var color_fabric = 0
var RunButton = false
var delay = 0
var i = 2
onready var drawer = get_node("Level2Drawer")
onready var grid = get_node("Level2Grid")
onready var hud = get_node("Level2HUD")
onready var gridID_Back = get_node("Level2Drawer/GridMachine")


# Called when the node enters the scene tree for the first time.
func reset():
	Global.cotton = 0
	Global.thread = 0
	Global.fabric = 0
	Global.color = 0
	Global.color_fabric = 0
	Global.RunButton = false

func _ready():
	reset()
	Global.money = money
	Global.cotton = cotton
	Global.color = color
	Global.thread = thread
	Global.fabric = fabric
	Global.color_fabric = color_fabric
	Global.mission = mission

	Global.RunButton = false
	
	Global.allRestNodes = get_tree().get_nodes_in_group('restZone')

func _process(delta):
	if(Global.RunButton == true):
		if(Global.restNodesGridPos[1][2].selected == true) and Global.restNodesGridPos[1][2].machine.type == 'Loom':
			while(Global.cotton >= 5):
				Global.cotton = Global.cotton - 5
				Global.thread = Global.thread+1
		if(Global.restNodesGridPos[2][4].selected == true) and Global.restNodesGridPos[2][4].machine.type == 'Sewing':
				while(Global.thread >= 5):
					Global.thread = Global.thread - 5
					Global.fabric = Global.fabric + 1
		if(Global.restNodesGridPos[1][6].selected == true) and Global.restNodesGridPos[1][6].machine.type == 'Dyeing':
			while(Global.fabric >= 1 and Global.color >= 1):
				Global.fabric = Global.fabric - 1
				Global.color = Global.color - 1
				Global.color_fabric = Global.color_fabric + 1
		if(Global.color_fabric == 3):
			mission = 1
			Global.mission = mission

