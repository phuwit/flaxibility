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
		if sourcePos >= 0 and sourcePos <= maxarrayindex and targetPos >= 0 and targetPos <= maxarrayindex:
			var target = allnodes[nodespos[targetPos]]
			var source = allnodes[nodespos[sourcePos]]
			if target.holding == true:
#				todo: play anim
				yield(get_tree().create_timer(1.0), "timeout")
				target.holding = holding
				holding = null
