extends Node3D

var cursor_state = true
@onready var label = $SubViewport/Label
@export var labelTexts: PackedStringArray

func _ready():
	labelTexts.push_back("█")
	var labelText = "\n".join(labelTexts)
	label.text = labelText

func _on_timer_timeout():
	if cursor_state:
		label.text[-1] = " "
		cursor_state = false
	else:
		label.text[-1] = "█"
		cursor_state = true