extends OmniLight3D

@onready var flickoff = $FlickoffTimer
@onready var flickon = $FlickonTimer

func _ready():
	flickoff.wait_time = randf_range(240, 480)
	


func interact():
	if visible:
		visible = false
	else:
		visible = true
