extends Control

var itemList = []
var heldItem

func _ready():
	itemList.append("Empty hand")
	heldItem = 0

func obtainItem(item):
	itemList.append(item)

func removeItem(item):
	itemList.erase(item)

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
