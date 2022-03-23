extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_buttons(get_tree().root)
	get_tree().connect("node_added", self, "_on_SceneTree_node_added")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# automatically add button sounds from https://gamedev.stackexchange.com/questions/184354/add-a-sound-to-all-the-buttons-in-a-project
func _on_SceneTree_node_added(node):
	if node is Button:
		connect_to_button(node)

func _on_Button_pressed():
	get_node('SoundClickPlayer').play()

# recursively connect all buttons
func connect_buttons(root):
	for child in root.get_children():
		if child is BaseButton:
			connect_to_button(child)
		connect_buttons(child)

func connect_to_button(button):
	button.connect("pressed", self, "_on_Button_pressed")

func change_to_scene_path(path):
	var error = get_tree().change_scene(path)
	if error != 0:
		print ("An unexpected error occured when trying to switch to the new scene, error code : " + error)

func _on_ButtonPlay_pressed():
	get_node("LevelsContainer").visible = not get_node("LevelsContainer").visible

func _on_ButtonExit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _on_Button0_pressed():
	change_to_scene_path("res://Levels/Level0/Level0.tscn")

func _on_Button1_pressed():
	change_to_scene_path("res://Levels/Level1/Level1.tscn")

func _on_Button2_pressed():
	change_to_scene_path("res://Levels/Level2/Level2.tscn")

func _on_Button3_pressed():
	change_to_scene_path("res://Levels/Level3/Level3.tscn")

func _on_Button4_pressed():
	change_to_scene_path("res://Levels/Level4/Level4.tscn")

func _on_Button5_pressed():
	change_to_scene_path("res://Levels/Level5/Level5.tscn")

func _on_Button6_pressed():
	change_to_scene_path("res://Levels/Level6/Level6.tscn")
