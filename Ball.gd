extends RigidBody2D

var ball_scene = null
var picked_up = false
var hovered = false

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta):
	if Input.is_action_just_pressed("click"):
		if hovered and not picked_up:
			pick_up_ball(true)
		elif picked_up:
			pick_up_ball(false)
		
	if picked_up:
		follow_mouse()
		
	if position.y > 1000:
		queue_free()
			
func follow_mouse():
	position = get_global_mouse_position()

func pick_up_ball(pick_up):
	picked_up = pick_up
	if picked_up == false:
		var new_ball = ball_scene.instantiate()
		new_ball.position = get_global_mouse_position()
		new_ball.rotation = rotation
		new_ball.ball_scene = ball_scene
		get_parent().add_child(new_ball)
		queue_free()

func _on_mouse_entered():
	hovered = true

func _on_mouse_exited():
	hovered = false
