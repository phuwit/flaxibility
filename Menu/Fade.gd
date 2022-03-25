extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal fade_finished


# Called when the node enters the scene tree for the first time.
# func _ready():
# 	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fade():
	get_node('FadeAnimation').play('FadeAnimation')

func reverse_fade():
	get_node('FadeAnimation').play('ReverseFadeAnimation')

func _on_FadeAnimation_animation_finished(_anim_name:String):
	emit_signal('fade_finished')
