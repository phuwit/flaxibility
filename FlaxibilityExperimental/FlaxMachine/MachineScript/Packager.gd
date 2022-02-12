extends Area2D


var cost = 40
var type = "Packager"
var shortestDist = 100

var mouse_over = false
var clicked = false
var restPoint
var restNodes = []

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

func _input(event):
	if (mouse_over == true) and (event is InputEventMouseButton) and (event.button_index == BUTTON_LEFT) and (event.pressed == true):
		get_tree().set_input_as_handled()
#		print("clicked")
		clicked = true
	elif (event is InputEventMouseButton) and (event.pressed == false):
		clicked = false
		for child in restNodes:
			var distanceToRest  = global_position.distance_to(child.global_position)
#			print('in loop as ', child, '; distanceToRest = ', distanceToRest, '; shortest dist = ', shortestDist)
			if distanceToRest < shortestDist:
				child.select()
				restPoint = child.global_position
#				print('snapped to ', restPoint, '; distanceToRest = ', distanceToRest)

func _on_MachinePackager_mouse_entered():
	mouse_over = true
	# print("MOUSE OVER LAEW")

func _on_MachinePackager_mouse_exited():
	mouse_over = false
	# print("MOUSE EXIT LAEW")
