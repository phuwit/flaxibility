extends Node2D


var restNodesX = []
var restNodesY = []
var gridColumn = 2
var girdRows = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	var restNodesCount = get_tree().get_nodes_in_group("restZones").size()
	for child in get_tree().get_nodes_in_group('restZones'):
		restNodesCount = 
		# print(child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
