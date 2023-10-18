extends Node3D

@onready var animation = $AnimationPlayer

@export var open: bool = false
@export var locked = false

func _ready():
	if open == false:
		animation.seek(0.0, true)

func interact():
	if !open and !locked:
		open = true
		animation.play("door_open")
		print("Opening doors")
	elif open:
		open = false
		animation.play_backwards("door_open")
		print("Closing doors")

func unlockDoor(item):
	pass
