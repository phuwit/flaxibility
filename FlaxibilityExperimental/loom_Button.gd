extends Button
var loom = preload("res://FlaxMachine/Test loom.tscn")
var screensize = Vector2(1920,1080)


func _ready():
	pass # Replace with function body.

func _toggled(button_pressed):
	loom = loom.instance()
	loom.position = Vector2(rand_range(0,screensize.x),rand_range(0,screensize.y))
	add_child(loom)
