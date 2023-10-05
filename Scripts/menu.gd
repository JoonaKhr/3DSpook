extends Control

var config = ConfigFile.new()

@export_file("*tscn") var level

# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_start_pressed():
	get_tree().change_scene_to_file(level)

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	if $SettingsPanel.is_visible_in_tree():
		$MenuAnimations.play_backwards("Settings")
	else:
		$MenuAnimations.play("Settings")


func _on_apply_pressed():
	config.set_value("volume", "Master", $SettingsPanel/VolumeCont/Master.value)
	config.set_value("volume", "Music", $SettingsPanel/VolumeCont/Music.value)
	config.set_value("volume", "Sfx", $SettingsPanel/VolumeCont/Sfx.value)

	config.save("user://settings.ini")


func _on_close_pressed():
	$MenuAnimations.play_backwards("Settings")


func _on_btn_mouse_exited():
	release_focus()
