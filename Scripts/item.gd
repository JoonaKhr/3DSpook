extends Node3D

var n = ""
@export var itemIcon: Image

func pickupItem(pickupee):
    pickupee.inventory.obtainItem(self)
