# extends Node3D

# var cursor_state = true
# @onready var label = $SubViewport/Label
# @export var label_text_array: PackedStringArray
# var label_text

# func _ready():
# 	label_text_array.push_back("█")
# 	label_text = "\n".join(label_text_array)
	
# 	label.text = label_text

# func update_text(new_text_array):
# 	new_text_array.push_back("█")
# 	label_text = "\n".join(new_text_array)
# 	label.text = label_text

# func _on_timer_timeout():
# 	if cursor_state:
# 		label.text[-1] = " "
# 		cursor_state = false
# 	else:
# 		label.text[-1] = "█"
# 		cursor_state = true

extends Node3D

@onready var display = $MeshInstance3D
@onready var viewport = $SubViewport
@onready var area = $Area3D
@onready var text_edit = $SubViewport/Computerterminalscreen/TextEdit
signal press()


# Called when the node enters the scene tree for the first time.
func _ready():
	viewport.set_process_input(true)
	
	
func _unhandled_input(event):
	pass
	

func _on_computerterminalscreen_gui_input(event:InputEvent):
	pass # Replace with function body.
		

func _on_press():
	viewport.get_node("Computerterminalscreen").grab_focus()
	print("get pressed on")


func _on_focus_entered():
	print("Get focused idiot")
