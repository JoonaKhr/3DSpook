extends StaticBody3D

# @export var text_file: Resource
# @export var json_header: String
# @onready var monitor = $monitor
# @onready var monitor_screen = monitor.get_node("SubViewport").get_node("Computerterminalscreen")

# signal press()

# func _ready():
# 	load_file(text_file)

# func load_file(file):
# 	var text_array = file.data[json_header].split("/", true, 0)
# 	monitor.update_text(text_array)


# func _on_press():
# 	monitor_screen.grab_focus()

@onready var monitor = $Monitor
@onready var monitor_viewport = $Monitor/MonitorViewport
@onready var monitor_control = $Monitor/MonitorViewport/MonitorControl
signal press()


# Called when the node enters the scene tree for the first time.
func _ready():
    monitor_viewport.set_process_input(true)
    monitor_control.focus_entered.connect(_on_focus_entered)

func _unhandled_input(event):
    if get_tree().get_root().gui_get_focus_owner() == monitor_control:
        monitor_viewport.push_input(event, true)

func _on_press():
    monitor_control.grab_focus()
    print("get pressed on")

func _on_focus_entered():
    print("Get focused idiot")