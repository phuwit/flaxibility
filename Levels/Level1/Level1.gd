extends Control



var restNodesPos
var mission = 0 
var money = 100
var color = 0
var cotton = 10
var thread = 0
var fabric = 0
var color_fabric = 0
var RunButton = false
var delay = 0
var i = 2
onready var drawer = get_node("Level1Drawer")
onready var grid = get_node("Level1Grid")
onready var hud = get_node("Level1HUD")
onready var gridID_Back = get_node("Level1Drawer/GridMachine")

func reset():
	Global.cotton = 0
	Global.thread = 0
	Global.RunButton = false
# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	Global.money = money
	Global.cotton = cotton
	Global.thread = thread
	Global.mission = mission

	Global.RunButton = false
	
	Global.allRestNodes = get_tree().get_nodes_in_group('restZone')
	# print(Global.allRestNodes)

func _process(delta):
	if(Global.RunButton == true):
		if(Global.restNodesGridPos[2][4].selected == true)and Global.restNodesGridPos[2][4].machine.type == 'Loom':
			while(Global.cotton >= 5):
				Global.cotton = Global.cotton - 5
				Global.thread = Global.thread+1
			if(Global.thread == 2):
				mission = 1
				Global.mission = mission
