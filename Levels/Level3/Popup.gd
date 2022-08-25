extends Popup



func _ready():
	pass 


func _process(delta):
	if Global.mission == 1:
		popup()
