extends Position2D


var selected = false
var machine

var posY
var posX


# inactive snapping area
func deselect():
	selected = false
	machine = null
#	modulate = Color.white

# active "snapped" area
func select():
	selected = true
#	for child in get_tree().get_nodes_in_group('restZones'):
#		child.deselect()
#	modulate = Color.aquamarine
