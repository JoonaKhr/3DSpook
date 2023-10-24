extends Node3D

var itemDict = {}
var heldItem
var index

# Fill the inventory with null slots, set index to zero and helditem as the first null slot in inventory
func _ready():
	for child in get_children():
		itemDict[child] = null
	index = 0
	heldItem = get_child(index)

# Pickup an item if holding null
func obtainItem(item):
	if itemDict[heldItem] == null:
		item.get_parent().remove_child(item)
		heldItem.add_child(item)
		itemDict[heldItem] = item
		item.global_position = heldItem.global_position
	else:
		pass

# Remove item (unused)
func removeItem(item):
	for child in get_children():
		if child.get_child(0) == item:
			itemDict.erase(item)
	itemDict.erase(item)
	item.queue_free()

# Mousewheel changes held item
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
