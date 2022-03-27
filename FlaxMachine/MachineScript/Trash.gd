extends Position2D


var selected = false
var machine

var posY
var posX

signal trashed

# inactive snapping area
func deselect():
	selected = false
	machine = null
	# modulate = Color.white

# active "snapped" area
func select():
	selected = true
	var cost = machine.cost
	machine.queue_free()
	Global.money += cost
	emit_signal('trashed')
	deselect()
	# for child in get_tree().get_nodes_in_group('restZones'):
	# 	child.deselect()
	# modulate = Color.aquamarine
