extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.allRestNodesGrid = get_tree().get_nodes_in_group('restZonesGrid')
	
	Global.gridColumn = 7 # start counting at 0
	Global.gridRows = 5 # start counting at 0
	
	Global.maxArrayIndex = (Global.gridColumn * 10) + Global.gridRows
#	var maxArrayIndex = int(Global.gridColumn*gridRows)
	
	Global.restNodesGridPos = generate_pos_array(Global.gridColumn, Global.gridRows, Global.allRestNodesGrid)
	Global.restNodesGridPos[0][0].selected = true
	Global.restNodesGridPos[0][7].selected = true

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
