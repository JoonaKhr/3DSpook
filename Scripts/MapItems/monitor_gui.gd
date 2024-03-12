extends Control

var times_pressed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	times_pressed += 1
	if times_pressed == 69:
		$Button.text = str("It was pressed ", "nice!", " times.")
	else:
		$Button.text = str("It was pressed ", times_pressed, " times.")
