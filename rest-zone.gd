extends Position2D

func _draw():
	draw_circle(Vector2.ZERO, 75, Color.salmon)

# inactive snapping area
func deselect():
	modulate = Color.white

# active "snapped" area
func select():
	for child in get_tree().get_nodes_in_group('zone'):
		child.deselect()
	modulate = Color.aquamarine