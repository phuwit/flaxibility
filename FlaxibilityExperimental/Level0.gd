extends Node2D


var restNodesPos = $Level0Grid.restNodesPos
var money = 100
var cotton = 100


func _ready():
	get_node($Level0Grid).call(restNodesPos)
	print(restNodesPos)
		
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
