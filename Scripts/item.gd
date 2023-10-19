extends Node3D

@export var iname = ""
@export var descrip = ""
@export var color: Color
signal press

func pickupItem():
	print("Picked up: ", iname)
	get_parent().get_node("Player").inventory.obtainItem(self)

func useItem(target):
	if get_tree().get_nodes_in_group("doorswitches").has(target):
		target.readkeycard(self)
	print("Trying to use item ", iname, " on ", target)



func _on_press():
	pickupItem()
