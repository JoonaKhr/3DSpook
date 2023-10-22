extends Node3D

@onready var animation = $AnimationPlayer

@export var open: bool = false
@export var locked = false
var cardReaders = []

func _ready():
	if open == false:
		animation.seek(0.0, true)
	for child in self.get_children():
		if get_tree().get_nodes_in_group("doorswitches").has(child):
			cardReaders.append(child)

func interact():
	if !open and !locked:
		openDoor()
		print("Opening doors")
	elif open:
		closeDoor()
		print("Closing doors")

func openDoor():
	open = true
	animation.play("door_open")

func closeDoor():
	open = false
	animation.play_backwards("door_open")

func _on_close_timer_timeout():
	closeDoor()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "door_open" and open == true:
		$closeTimer.start()
		for child in cardReaders:
			child.openLight()
	else:
		$closeTimer.stop()
		for child in cardReaders:
			child.lockDoors()
