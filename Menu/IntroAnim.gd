extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_to_scene_path(path):
	var error = get_tree().change_scene(path)
	if error != 0:
		print ("An unexpected error occured when trying to switch to the new scene, error code : " + error)

func _on_VideoPlayer_finished():
	change_to_scene_path('res://Menu/MainMenu.tscn')


func _input(event:InputEvent):
	if (event is InputEventKey) or (event is InputEventMouseButton):
		change_to_scene_path('res://Menu/MainMenu.tscn')

