extends Node3D

@export var iname = ""
@export var descrip = ""
signal press

func pickupItem():
	print("Picked up: ", iname)
	get_parent().get_node("Player").inventory.obtainItem(self)
	$CollisionShape3D.disabled = true

func useItem(target):
	print("Trying to use item ", iname, " on ", target)



func _on_press():
	pickupItem()
