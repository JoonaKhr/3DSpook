extends StaticBody3D

var open: bool = false
signal press

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_press():
	if !open:
		$AnimationPlayer.play("cabinet_open")
		open = true
	elif open:
		$AnimationPlayer.play_backwards("cabinet_open")
		open = false
