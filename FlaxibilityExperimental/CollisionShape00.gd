extends CollisionShape2D

var cotton = 0
var thread = 0
var fabric = 0
var color_fabric = 0





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_CoolDown_timeout():
	if Global.gridID[0] == 0:
		if cotton >= 5:
			cotton = cotton - 5
			fabric += 1
	if Global.gridID[0] == 1:
		if (fabric >= 1) and (Global.color >= 1):
			Global.color = Global.color - 1
			fabric = fabric - 1
			color_fabric += 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
