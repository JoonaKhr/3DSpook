extends Node3D

var cursor_state = true
@onready var label = $SubViewport/Label
@export var label_text_array: PackedStringArray
var label_text

func _ready():
	label_text_array.push_back("█")
	label_text = "\n".join(label_text_array)
	
	label.text = label_text

func update_text(new_text_array):
	new_text_array.push_back("█")
	label_text = "\n".join(new_text_array)
	label.text = label_text

func _on_timer_timeout():
	if cursor_state:
		label.text[-1] = " "
		cursor_state = false
	else:
		label.text[-1] = "█"
		cursor_state = true
