extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_teleport_body_entered(body:Node3D):
	if body.is_in_group("player"):
		body.global_position.z = $exit_teleport/teleport.global_position.z
