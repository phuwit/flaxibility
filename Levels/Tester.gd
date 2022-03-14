extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var node = get_node('RestZone')
	print(node)
	get_node('MachineLoom').snap_to(node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
