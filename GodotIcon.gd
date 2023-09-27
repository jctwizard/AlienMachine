extends Sprite2D

@export_category("Movement Variables")
@export
var speed = 400
@export
var angular_speed = PI

func _init():
	print("Alien Machine")
	
func _ready():
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	set_process(false)
	
func _process(delta):
	var turn_direction = 0
	if Input.is_action_pressed("ui_left"):
		turn_direction = -1
	if Input.is_action_pressed("ui_right"):
		turn_direction = 1
	
	rotation += angular_speed * turn_direction * delta
	
	var move_direction = 0
	if Input.is_action_pressed("ui_up"):
		move_direction = 1
	if Input.is_action_pressed("ui_down"):
		move_direction = -1
		
	var target_velocity = Vector2.UP.rotated(rotation) * move_direction * speed
	
	position += target_velocity * delta


func _on_button_pressed():
	set_process(not is_processing())

func _on_timer_timeout():
	visible = not visible
	
