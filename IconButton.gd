extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "move"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if text == "moving":
		text = "move"
	else:
		text = "moving"