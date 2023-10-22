extends StaticBody3D


@export var requiredColor: Color
@onready var cardLight = $cardLight/indicatorLight
@onready var unlockLight = $unlockLight/indicatorLight
@onready var timer = $unlockLight/Timer
signal press
var door

func _ready():
	cardLight.material_override.emission = requiredColor
	door = get_parent()
	if door.locked != true:
		unlockLight.material_override.emission = Color(0, 255, 0, 255)
			
func lockDoors():
	door.locked = true
	unlockLight.material_override.emission = Color(255, 0, 0, 255)

func unlockDoors():
	door.locked = false
	unlockLight.material_override.emission = Color(0, 255, 0, 255)

func openLight():
	unlockLight.material_override.emission = Color(255, 255, 255, 255)

func readkeycard(card):
	print("Reading card")
	if card.color == requiredColor:
		unlockDoors()
	else:
		unlockLight.material_override.emission_enabled = false
		timer.start()
		

func _on_timer_timeout():
	unlockLight.material_override.emission_enabled = true

func _on_press():
	door.interact()
