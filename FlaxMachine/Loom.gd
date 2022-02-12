extends Area2D


var cost = 30
var type = "Loom"

var mouse_over = false
var clicked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if clicked == true:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	#else:
	#	global_position = lerp(global_position, rest_point, 10 * delta)
	#pass


func _input(event):
	if (mouse_over == true) and (event is InputEventMouseButton) and (event.button_index == BUTTON_LEFT) and (event.pressed):
		get_tree().set_input_as_handled()
		print("clicked")
		clicked = true
	elif (mouse_over == true):
		clicked = false



func _on_LoomMachine_mouse_entered():
	mouse_over = true
	print("MOUSE OVER LAEW")
	pass # Replace with function body.


func _on_LoomMachine_mouse_exited():
	mouse_over = false
	pass # Replace with function body.
