extends Control


#var allRestNodesGrid #moved to Global.allRestNodesGrid

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.allRestNodesGrid = get_tree().get_nodes_in_group('restZonesGrid')
	
	Global.gridColumn = 1 # start counting at 0
	Global.gridRows = 1 # start counting at 0
	
	Global.maxArrayIndex = (Global.gridColumn * 10) + Global.gridRows
#	var maxArrayIndex = int(Global.gridColumn*gridRows)
	
	Global.restNodesGridPos = generate_pos_array(Global.gridRows, Global.gridColumn, Global.allRestNodesGrid)

func generate_pos_array(width, height, allNodes):
	var array = []
	var currentIndex = 0
	width += 1
	height += 1
	
	for y in range(height):
		array.append([])
		array[y].resize(width)
	
		for x in range(width):
			array[y][x] = allNodes[currentIndex]
			allNodes[currentIndex].posY = y
			allNodes[currentIndex].posX = x
			currentIndex += 1
	
#	print(array)
	return array

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Timer_timeout():
#	pass # Replace with function body.
