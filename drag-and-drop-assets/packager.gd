extends Node2D

var selected = false

func _on_Area2D_input_event(_viewport, _event, _shape_idx):
# func _on_Area2D_input_event():
# removing the argements breaks it. so, dirty code it is.
	if Input.is_action_just_pressed('click'):
		selected = true

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

