extends Control



var restNodesPos 
var money = 100
var color = 30
var cotton = 0
var thread = 60
var fabric = 0
var color_fabric = 0
var RunButton = false
var delay = 0
var i = 2
onready var drawer = get_node("Level5Drawer")
onready var grid = get_node("Level5Grid")
onready var hud = get_node("Level5HUD")
onready var gridID_Back = get_node("Level5Drawer/GridMachine")


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.money = money
	Global.cotton = cotton
	Global.color = color

	Global.RunButton = false
	
	Global.allRestNodes = get_tree().get_nodes_in_group('restZone')
	print(Global.allRestNodes)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
