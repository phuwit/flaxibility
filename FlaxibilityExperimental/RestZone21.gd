extends Position2D

#func _draw():
#	draw_circle(Vector2.ZERO, 100, Color.salmon)
#	draw_rect(Rect2(Vector2(0, 0), Vector2(1, 1), Color.salmon)
var coord = Vector2(0,1)
# inactive snapping area
func deselect():
	modulate = Color.white

# active "snapped" area
func select():
	for child in get_tree().get_nodes_in_group('restZones'):
		child.deselect()
	modulate = Color.aquamarine
