extends Control



var restNodesPos 
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


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.money = money
	Global.cotton = cotton
	Global.color = color

	Global.RunButton = false
	
	Global.allRestNodes = get_tree().get_nodes_in_group('restZone')
	# print(Global.allRestNodes)

	hud.get_node('GridContainer/ButtonStart').connect('pressed', drawer, '_on_ButtonStart_pressed')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass