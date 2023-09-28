extends Area2D

signal player_hit

const KEY_LEFT = "move_left"
const KEY_RIGHT = "move_right"
const KEY_UP = "move_up"
const KEY_DOWN = "move_down"

const TURN_ANIM = "turn" 
const MOVE_ANIM = "move" 

@export var move_acceleration = 10000
@export var max_move_speed = 5000
@export var turn_acceleration = PI * 4
@export var max_turn_speed = PI
var screen_size
var current_turn_speed = 0
var current_move_speed = 0

var sprite : AnimatedSprite2D
var collider : CollisionShape2D

func _ready():
	screen_size = get_viewport_rect().size
	sprite = $Sprite
	collider = $Collider
	hide()

func _process(delta):
	var turn_direction = 0
	if Input.is_action_pressed(KEY_LEFT):
		turn_direction = -1
		sprite.flip_h = true
	if Input.is_action_pressed(KEY_RIGHT):
		turn_direction = 1
		sprite.flip_h = false
	if turn_direction != 0:
		sprite.animation = TURN_ANIM
	
	current_turn_speed += turn_acceleration * turn_direction * delta
	current_turn_speed = clampf(current_turn_speed, -max_turn_speed, max_turn_speed)
	rotation += current_turn_speed * delta
	
	var move_direction = 0
	if Input.is_action_pressed(KEY_UP):
		move_direction = 1
	if Input.is_action_pressed(KEY_DOWN):
		move_direction = -1
	if turn_direction != 0:
		sprite.animation = MOVE_ANIM
		
	current_move_speed += move_acceleration * move_direction * delta
	current_move_speed = clampf(current_move_speed, -max_move_speed, max_move_speed)
		
	var velocity = Vector2.UP.rotated(rotation) * current_move_speed * delta
	
	if velocity.length() > 0:
		sprite.play()
	else:
		sprite.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func restart(spawn_position):
	position = spawn_position
	show()
	collider.disabled = false

func _on_body_entered(_body):
	hide()
	player_hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	collider.set_deferred("disabled", true)
