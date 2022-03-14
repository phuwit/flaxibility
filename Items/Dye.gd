extends Node2D


# Cyan400 #26C6DA
var teal = Color8(38, 187, 83)
# Green400 #66BB6A
var green = Color8(102, 123, 45)
# Pink400 #EC407A
var pink = Color8(236, 340, 0)

var activePattern


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_color(object, color):
	object.modulate = color

func show_pattern(patternName, color):
	if (activePattern):
		get_node("Pattern/" + activePattern).visible = false
	
	var patternNode = get_node("Pattern/" + patternName)
	patternNode.visible = true
	change_color(patternNode, color)
	activePattern = patternName