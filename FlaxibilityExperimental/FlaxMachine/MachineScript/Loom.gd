extends Area2D


var cost = 30
var type = "Loom"
var shortestDist = 60 

var mouse_over = false
var clicked = false
var restPoint
var restNodes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	restNodes = get_tree().get_nodes_in_group('restZones')
	restPoint = restNodes[0].global_position
	restNodes[0].select()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (clicked == true) and (mouse_over == true):
		# global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		global_position = get_global_mouse_position()
	else:
		global_position = lerp(global_position, restPoint, 10 * delta)
	# pass

func _input(event):
	if (mouse_over == true) and (event is InputEventMouseButton) and (event.button_index == BUTTON_LEFT) and (event.pressed == true):
		get_tree().set_input_as_handled()
		print("clicked")
		clicked = true
	elif (event is InputEventMouseButton) and (event.pressed == false):
		clicked = false
		for child in restNodes:
			var distanceToRest  = global_position.distance_to(child.global_position)
			if distanceToRest < shortestDist:
				child.select()
				restPoint = child.global_position
				shortestDist = distanceToRest
func _on_MachineLoom_mouse_entered():
	mouse_over = true
	print("MOUSE OVER LAEW")

func _on_MachineLoom_mouse_exited():
	mouse_over = false
	print("MOUSE EXIT LAEW")
