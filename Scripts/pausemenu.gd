extends Control

@export_file("*tscn") var menu

var config = ConfigFile.new()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		btn_sfx()
		if !get_tree().paused:
			$".".visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused = true
		else:
			$".".visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false

func _on_continue_pressed():
	btn_sfx()
	$".".visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_quit_menu_pressed():
	$".".visible = false
	get_tree().paused = false
	ResourceLoader.load_threaded_request(menu)
	get_tree().change_scene_to_file(menu)

func _on_apply_pressed():
	config.set_value("volume", "Master", $Panel/Panel/VolumeCont/Master.value)
	config.set_value("volume", "Music", $Panel/Panel/VolumeCont/Music.value)
	config.set_value("volume", "Sfx", $Panel/Panel/VolumeCont/Sfx.value)

	config.save("user://settings.ini")
	
	$apply.play()


func _on_settings_pressed():
	btn_sfx()
	if $Panel/Panel.is_visible_in_tree():
		$AnimationPlayer.play_backwards("settings")
	else:
		$AnimationPlayer.play("settings")

func _on_close_pressed():
	btn_sfx()
	$AnimationPlayer.play_backwards("settings")

func _on_quit_game_pressed():
	get_tree().quit()

func btn_sfx():
	$button.play()
