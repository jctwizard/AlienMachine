extends Node

@export var Ball: PackedScene

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var new_ball = Ball.instantiate()
		new_ball.position = get_viewport().get_mouse_position()
		new_ball.ball_scene = Ball;
		add_child(new_ball)
