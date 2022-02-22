extends Control


#var allRestNodesGrid #moved to Global.allRestNodesGrid

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.allRestNodesGrid = get_tree().get_nodes_in_group('restZonesGrid')
	
	var gridColumn = 1 # start counting at 0
	var gridRows = 1 # start counting at 0
#	var maxArrayIndex = int(gridColumn*gridRows)
	
	generate_pos_array(gridColumn, gridRows)

func generate_pos_array(gridColumn, gridRows):
	var restNodesGridPos = []
	var currentColumn = 0
	var currentRow = 0
	var arrayIndex
	var currentChild = 0
	var maxArrayIndex = int(String(gridColumn) + String(gridRows)) + 1
	
	restNodesGridPos.resize(maxArrayIndex)

	for child in Global.allRestNodesGrid:
#		print('child = ', child, 'currentChild = ', currentChild)
		# print(get_tree().get_nodes_in_group('restZones'))
		if currentRow > gridRows:
#			print('currentRow = ', currentRow)
			currentRow = 0
			currentColumn += 1
		arrayIndex = int(String(currentColumn) + String(currentRow))
#		print('arrayindex = ', arrayIndex)
		restNodesGridPos[arrayIndex] = child
#		print(restNodesPos[arrayIndex])
		currentChild += 1
		currentRow += 1
	
	Global.restNodesGridPos = restNodesGridPos


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Timer_timeout():
#	pass # Replace with function body.
