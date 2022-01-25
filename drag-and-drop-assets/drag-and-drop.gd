extends Node2D

var selected = false
var rest_point
var rest_nodes = []

func _ready():
	rest_nodes = get_tree().get_nodes_in_group('zone')
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()

# Interpolate obj position to mouse position
func _physics_process(delta):
	if selected == true:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		# if you want to make the object "rotates" around your mouse vector
		# look_at(get_global_mouse_position())
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)
		# rotation = lerp_angle(rotation, 0, 10 * delta)

func _input(event):
	if event is InputEventMouseButton:
		# when the mouse button released -> flip selected to false
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			# shortest distance for snapping
			var shortest_dist = 75
			for child in rest_nodes:
				var distance  = global_position.distance_to(child.global_position)
				# if in snapping dist; snap to it
				if distance < shortest_dist:
					child.select()
					rest_point = child.global_position
					shortest_dist = distance


func _on_MachineTemplate_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true
