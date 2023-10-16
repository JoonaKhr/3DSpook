extends StaticBody3D

@onready var animation = $AnimationPlayer

var open = false
@export var locked = false
@export var requiredItem: PackedScene

func _ready():
    var openAnimation = animation.get_animation("open")
    if rotation_degrees.y != 90:
        openAnimation.track_set_key_value(0, 0, Vector3(transform.origin.x, transform.origin.y, transform.origin.z))
        openAnimation.track_set_key_value(0, 1, Vector3(transform.origin.x, transform.origin.y, (transform.origin.z + 10)))
    else:
        openAnimation.track_set_key_value(0, 0, Vector3(transform.origin.x, transform.origin.y, transform.origin.z))
        openAnimation.track_set_key_value(0, 1, Vector3(transform.origin.x+10, transform.origin.y, transform.origin.z))

func interact():
    if !open and !locked:
        open = true
        animation.play("open")
    elif open:
        open = false
        animation.play_backwards("open")

func unlockDoor(item):
    if item == requiredItem:
        locked = false
    else:
        print("Requires item: ", requiredItem.iName)