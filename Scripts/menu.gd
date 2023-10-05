extends Control

@export_file("*tscn") var level

# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_pressed():
	get_tree().change_scene_to_file(level)

func _on_quit_pressed():
	get_tree().quit()