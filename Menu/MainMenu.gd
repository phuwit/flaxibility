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


func _on_ButtonPlay_pressed():
	get_node("LevelsContainer").visible = not get_node("LevelsContainer").visible

func _on_ButtonExit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _on_Button0_pressed():
	get_tree().change_scene('res://Levels/Level0/Level0.tscn')
