extends Area2D

@export var move_acceleration = 10000
@export var max_move_speed = 5000
@export var turn_acceleration = PI * 4
@export var max_turn_speed = PI
var screen_size
var current_turn_speed = 0
var current_move_speed = 0

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var turn_direction = 0
	if Input.is_action_pressed("ui_left"):
		turn_direction = -1
	if Input.is_action_pressed("ui_right"):
		turn_direction = 1
	
	current_turn_speed += turn_acceleration * turn_direction * delta
	current_turn_speed = clampf(current_turn_speed, -max_turn_speed, max_turn_speed)
	rotation += current_turn_speed * delta
	
	var move_direction = 0
	if Input.is_action_pressed("ui_up"):
		move_direction = 1
	if Input.is_action_pressed("ui_down"):
		move_direction = -1
		
	current_move_speed += move_acceleration * move_direction * delta
	current_move_speed = clampf(current_move_speed, -max_move_speed, max_move_speed)
		
	var velocity = Vector2.UP.rotated(rotation) * current_move_speed * delta
	
	if velocity.length() > 0:
		$Sprite.play()
	else:
		$Sprite.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
