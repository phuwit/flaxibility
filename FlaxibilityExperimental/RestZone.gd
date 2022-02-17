extends Position2D


var selected = false

#func _draw():
#	draw_circle(Vector2.ZERO, 100, Color.salmon)
#	draw_rect(Rect2(Vector2(0, 0), Vector2(1, 1), Color.salmon)
#var coord = Vector2(0,0)
# inactive snapping area
func deselect():
	selected = false
#	modulate = Color.white

# active "snapped" area
func select():
	selected = true
#	for child in get_tree().get_nodes_in_group('restZones'):
#		child.deselect()
#	modulate = Color.aquamarine
