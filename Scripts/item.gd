extends Node3D

var n = ""

func pickupItem(pickupee):
    pickupee.inventory.obtainItem(self)
    queue_free()
