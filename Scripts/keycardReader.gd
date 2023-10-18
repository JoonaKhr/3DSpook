extends StaticBody3D


@export var requiredColor: Color
@onready var cardLight = $cardLight/indicatorLight
@onready var unlockLight = $unlockLight/indicatorLight
signal press
var door

func _ready():
	cardLight.material_override.emission = requiredColor
	door = get_parent()
	if door.locked != true:
		unlockLight.material_override.emission = Color(0, 255, 0, 255)
			

func unlockDoors():
	pass


func _on_press():
	door.interact()
