extends HSlider

@export var bus_name: String

var config = ConfigFile.new()
var err = config.load("user://settings.ini")
var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
		
	if err != OK:
		return
	else:
		value = config.get_value("volume", bus_name)
	
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(value)
			)
	

func _on_value_changed(values: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(values)
	)


func _on_mouse_exited():
	release_focus()
