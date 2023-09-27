extends RigidBody2D

var picked_up = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if picked_up:
		if (Input.is_action_just_pressed("click")):
			pick_up_ball(false)
		else:
			follow_mouse()

func follow_mouse():
	position = get_global_mouse_position()

func pick_up_ball(pick_up):
	picked_up = pick_up
	set_physics_process(not picked_up)
	get_node("Button").disabled = picked_up

func _on_button_pressed():
	pick_up_ball(true)
