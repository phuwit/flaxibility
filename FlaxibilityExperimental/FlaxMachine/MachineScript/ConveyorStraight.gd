extends Area2D


var holding
var conveyorRotation


func _ready():
	pass # Replace with function body.


func _process(delta):
	pass
	if holding:
		match conveyorRotation:
			'north':
				pass
				targetPos = currentpos - 10
				sourcePos = currentpos + 10
			'east':
				pass
				targetPos = currentpos + 1
				sourcePos = currentpos - 1
			'south':
				pass
				targetPos = currentpos + 10
				sourcePos = currentpos - 10
			'west':
				pass
				targetPos = currentpos - 1
				sourcePos = currentpos - 1
		if targetPos >= 0 and targetPos <= maxarrayindex:
			var target = allnodes[nodespos[targetpos]]
			if target.type == machine:
				wait 1s
				play anim
				target.holding = holding
				holding = null
