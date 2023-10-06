extends Node3D

@onready var flickoff = $FlickoffTimer
@onready var flickon = $FlickonTimer
@onready var light = $OmniLight3D

func _ready():
	flickoff.wait_time = randf_range(240, 480)
	


func interact():
	print("wow such interaction")
	if light.visible:
		light.visible = false
	else:
		light.visible = true
