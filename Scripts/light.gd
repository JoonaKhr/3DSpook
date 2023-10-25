extends Node3D

var isLightOn = false
@onready var flickoff = $FlickoffTimer
@onready var light = $OmniLight3D
@onready var animations = $AnimationPlayer
@onready var lighttube = $lightCeiling_tube/lightCeiling_tube

func _ready():
	isLightOn = get_parent().state
	flickoff.wait_time = randf_range(120, 240)
	if isLightOn:
		flickoff.start()
		light.visible = true
	else:
		light.visible = false
		lighttube.material_override.emission_enabled = false

func interact():
# While the light is on start the flickering animation
	if light.visible:
		flickoff.stop()
		lighttube.material_override.emission_enabled = false
		light.visible = false
	else:
		flickoff.start()
		lighttube.material_override.emission_enabled = true
		light.visible = true

# Play spooky flickering animations
func _on_flickoff_timer_timeout():
	$AnimationPlayer.play(animations.get_animation_list()[randi_range(0, animations.get_animation_list().size()-1)])

func _process(_delta):
	lighttube.material_override.emission_energy = light.light_energy