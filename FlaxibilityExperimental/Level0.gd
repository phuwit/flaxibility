extends Node2D


var restNodesPos = []
var gridColumn = 1 # start counting at 0
var gridRows = 1 # start counting at 0

func _ready():
	var currentColumn = 0
	var currentRow = 0
	var arrayIndex
	var currentChild = 0
	
	var maxArrayIndex = int(String(gridColumn) + String(gridRows))
	restNodesPos.resize(maxArrayIndex)
	
	for child in get_tree().get_nodes_in_group('restZones'):
		print('child = ', child, 'currentChild = ', currentChild)
		# print(get_tree().get_nodes_in_group('restZones'))
		if currentRow > 2:
			currentRow = 0
			currentColumn += 1
			print('currentRow', currentRow)
		arrayIndex = int(String(currentColumn) + String(currentRow))
		print('arrayindex = ', arrayIndex)
		restNodesPos[arrayIndex] = currentChild
		print(restNodesPos[arrayIndex])
		currentChild += 1
		currentRow += 1
		
#	for i in restNodesCount:
#		print(i)
#		print(currentRow)
#		print(currentColumn)
#		if currentRow <= 2:
#			restNodesPos[currentRow + currentColumn] = child
#		elif currentRow > 2:
#			currentRow = 0
#			currentColumn += 1
#			print(currentRow)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
