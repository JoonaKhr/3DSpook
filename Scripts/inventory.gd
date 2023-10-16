extends Control

@onready var blankkeyholder = $BlankKeyHolder
var itemList = []
var heldItem

func _ready():
	itemList.append("Empty hand")
	heldItem = 0

func obtainItem(item):
	item.get_parent().remove_child(item)
	add_child(item)
	item.global_position = blankkeyholder.global_position
	itemList.append(item)

func removeItem(item):
	remove_child(item)
	itemList.erase(item)
	item.queue_free()

func changeHeldItem(input):
	if input == MOUSE_BUTTON_WHEEL_UP:
		if heldItem <= itemList.size():
			heldItem += 1
		if heldItem == itemList.size():
			heldItem = 0
	if input == MOUSE_BUTTON_WHEEL_DOWN:
		if heldItem >= 0:
			heldItem -= 1
		if heldItem < 0:
			heldItem = itemList.size()-1
	print(itemList[heldItem])
