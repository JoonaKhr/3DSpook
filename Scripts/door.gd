extends StaticBody3D

@onready var animation = $AnimationPlayer

var open = false

func interact():
    if !open:
        open = true
        animation.play("open")
    elif open:
        open = false
        animation.play_backwards("open")