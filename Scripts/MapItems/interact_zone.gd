extends Area3D


func _on_body_entered(body:Node3D):
	if body.name == "Player":
		Player.vars["enable_cursor"] = true


func _on_body_exited(body:Node3D):
	if body.name == "Player":
		Player.vars["enable_cursor"] = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)