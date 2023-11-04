extends Node3D

var item_list = []
var held_item
var index
var last_equipped

# Fill the inventory with null slots, set index to zero and held_item as the first null slot in inventory
func _ready():
	%Hand.get_child(0).visible = false
	for child in get_children():
		if child.has_signal("press"):
			item_list.append(child)
	index = 0
	held_item = item_list[index]
	print(item_list)

# Pickup an item if holding null
func obtainItem(item):
	for child in item_list:
		if child.iname == item.iname and child.activated == false:
			child.activate.emit()

func get_current_item():
	return item_list[index]

# Mousewheel changes held item
func change_held_item(input):
	var previous_held_item = item_list[index]
	if input == MOUSE_BUTTON_WHEEL_UP:
		if index <= item_list.size()-1:
			index += 1
		if index == item_list.size():
			index = 0
	if input == MOUSE_BUTTON_WHEEL_DOWN:
		if index >= 0:
			index -= 1
		if index < 0:
			index = item_list.size()-1
	held_item = item_list[index]
	if previous_held_item != null:
		previous_held_item.position = previous_held_item.original_position
		previous_held_item.rotation_degrees = Vector3(0, 90.0, 0)
	if held_item.activated == true:
		equip_to_hand()
	

func equip_to_hand():
	unequip()
	var hand_item = load(held_item.scene_file_path).instantiate()
	last_equipped = held_item
	held_item.visible = false
	hand_item.set("activated", held_item.get("activated"))
	hand_item.position = %Hand.position
	hand_item.rotation_degrees = Vector3(0, -90, 0)
	%Hand.add_child(hand_item)

func unequip():
	%Hand.get_child(1).queue_free()
	last_equipped.visible = true
