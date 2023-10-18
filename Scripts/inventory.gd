extends Node3D

var itemDict = {}
var heldItem
var index

func _ready():
	for child in get_children():
		itemDict[child] = null
	index = 0
	heldItem = get_child(index)

func obtainItem(item):
	if itemDict[heldItem] == null:
		item.get_parent().remove_child(item)
		heldItem.add_child(item)
		itemDict[heldItem] = item
		item.global_position = heldItem.global_position
	else:
		pass

func removeItem(item):
	for child in get_children():
		if child.get_child(0) == item:
			itemDict.erase(item)
	itemDict.erase(item)
	item.queue_free()

func changeHeldItem(input):
	if input == MOUSE_BUTTON_WHEEL_UP:
		if index <= get_child_count():
			index += 1
		if index == get_child_count():
			index = 0
	if input == MOUSE_BUTTON_WHEEL_DOWN:
		if index >= 0:
			index -= 1
		if index < 0:
			index = get_child_count()-1
	heldItem = get_child(index)
	print(itemDict[heldItem])
