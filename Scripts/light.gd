extends Node3D

@onready var flickoff = $FlickoffTimer
@onready var light = $OmniLight3D
@onready var animations = $AnimationPlayer

func _ready():
	flickoff.wait_time = randf_range(120, 240)
	


func interact():
	if light.visible:
		flickoff.stop()
		light.visible = false
	else:
		flickoff.start()
		light.visible = true


func _on_flickoff_timer_timeout():
	$AnimationPlayer.play(animations.get_animation_Dict()[randi_range(0, animations.get_animation_Dict().size()-1)])
