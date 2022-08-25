extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_buttons(get_tree().root)
	get_tree().connect("node_added", self, "_on_SceneTree_node_added")


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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func display_warning(text):
	get_node("Warning").visible = true
	get_node("Warning/WarningText").text = text
	get_node('SoundFailPlayer').play()
	get_node("Warning/WarningTimer").start()

func _on_WarningTimer_timeout():
	get_node("Warning").visible = false
	# get_node("Warning/WarningText").text = null


func _on_ButtonBack_pressed():
	get_tree().change_scene("res://Menu/MainMenu.tscn")


func _on_ButtonReset_pressed():
	get_tree().reload_current_scene()
