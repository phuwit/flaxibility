extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var i;

func _on_exit_pressed():
	get_tree().change_scene("res://main-menu.tscn")




func _on_Button_pressed():
	if(i == 0):
		get_tree().change_scene("res://level2.tscn");
		i = i+1;
	elif(i == 1):
		get_tree().change_scene("res://level3.tscn");
		i = i+1;
	elif(i == 2):
		get_tree().change_scene("res://level4.tscn");
		i = i+1;
	elif(i == 3):
		get_tree().change_scene("res://level5.tscn");
		i = i+1;
	else:
		get_tree().change_scene("res://level6.tscn");
		i = 0;
