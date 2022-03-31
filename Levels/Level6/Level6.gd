extends Control



var restNodesPos 
var money = 100
var color = 50
var cotton = 0
var thread = 0
var fabric = 100
var color_fabric = 0
var RunButton = false
var delay = 0
var i = 2
onready var drawer = get_node("Level6Drawer")
onready var grid = get_node("Level6Grid")
onready var hud = get_node("Level6HUD")
onready var gridID_Back = get_node("Level6Drawer/GridMachine")


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
