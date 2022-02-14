extends Button
const loom = preload("res://FlaxMachine/Loom.tscn")


func _ready():
	pass # Replace with function body.

func _toggled(button_pressed):
	var LoomMachine = loom.instance()
	$contrainer.add_child(LoomMachine)
	LoomMachine.position = Vector2(0,0)
