extends Node2D


var restNodesPos 
var money = 100
var cotton = 100
var fabric = 0
var RunButton = false
var delay = 0
var i = 2
onready var timer = get_node("Timer")



func _on_RunButton_pressed():
	if RunButton == true:
		RunButton = false
	else:
		RunButton = true
	while (cotton >= 5) and (RunButton == true):
		if cotton >= 5:
			cotton = cotton - 5
			Global.cotton = cotton
			fabric += 1
			Global.fabric = fabric
			yield(get_tree().create_timer(0.2),"timeout")
		else:
			break


func _ready():
	print('restzonesgroup = ', get_tree().get_nodes_in_group('restZones'))
	Global.money = money
	Global.cotton = cotton
	

