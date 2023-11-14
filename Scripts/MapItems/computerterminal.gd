extends StaticBody3D

@export var text_file: Resource
@export var json_header: String
@onready var monitor = $monitor

func _ready():
	load_file(text_file)

func load_file(file):
	var text_array = file.data[json_header].split("/", true, 0)
	monitor.update_text(text_array)
