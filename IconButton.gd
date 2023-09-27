extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "move"

func _on_pressed():
	if text == "moving":
		text = "move"
	else:
		text = "moving"
