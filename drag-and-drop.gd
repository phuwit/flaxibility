extends Node2D

var selected = false

# if clicked on the hitbox -> flip selected to true
func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

# Interpolate obj position to mouse position
func _physics_process(delta):
	if selected == true:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

# when the mouse button released -> flip selected to false
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
