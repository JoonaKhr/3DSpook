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
		item.position = Vector3(heldItem.position.x, 0.8, -0.5)
		item.rotation_degrees = Vector3(0, -90, 0)
	else:
		pass

func getCurrentItem():
	return itemDict[heldItem]

# Remove item (unused)
func removeItem(item):
	for child in get_children():
		if child.get_child(0) == item:
			itemDict.erase(item)
	itemDict.erase(item)
	item.queue_free()

# Mousewheel changes held item
func changeHeldItem(input):
	var previousHeldItem = itemDict[heldItem]
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
	if previousHeldItem != null:
		previousHeldItem.position = previousHeldItem.get_parent().position
		previousHeldItem.rotation_degrees = Vector3(0, 90.0, 0)
		print("previous item ", previousHeldItem)
		print("previous item parent ", previousHeldItem.get_parent())
	if itemDict[heldItem] != null:
		itemDict[heldItem].position = Vector3(itemDict[heldItem].position.x, 0.8, -0.5)
		getCurrentItem().rotation_degrees = Vector3(0, -90.0, 0)

	print("current item ", itemDict[heldItem])

