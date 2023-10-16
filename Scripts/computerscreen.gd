extends Node3D

var cursor_state = true


func _on_timer_timeout():
	if cursor_state:
		%cursor.text = ""
		cursor_state = false
	else:
		%cursor.text = "█"
		cursor_state = true