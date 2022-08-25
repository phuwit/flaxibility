extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if(Global.pack_color_fabric > 9):
		text = "Packed colored fabric : "+String(Global.pack_color_fabric)
	else:
		text = "Packed c_fabric : "+String(Global.pack_color_fabric)
