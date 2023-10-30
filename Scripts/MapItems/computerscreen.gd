extends Node3D

var cursor_state = true
@onready var label = $SubViewport/Label
@export var labelText: String

func _ready():
	label.text = labelText

func _on_timer_timeout():
	if cursor_state:
		%cursor.text = ""
		cursor_state = false
	else:
		%cursor.text = "█"
		cursor_state = true