extends Node2D

func go_title_screen():
	get_tree().change_scene("res://start.tscn")
	
func _input(event):
	if (event is InputEvent):
		go_title_screen()
func _on_AnimatedSprite2_animation_finished():
	go_title_screen()
