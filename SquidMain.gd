extends Node

const SQUID_GROUP = "squid"

@export var squid_scene : PackedScene
@export var min_squid_speed = 150.0
@export var max_squid_speed = 250.0
@export_range(0, 90) var squid_rotation_offset = 45.0
@export var min_squid_timer = 0.5
@export var squid_timer_decrease = 0.01

var squid_timer_initial_wait_time = 0

var player : Area2D

var spawn : Marker2D
var squid_spawn : PathFollow2D

var squid_timer : Timer
var score_timer : Timer
var start_timer : Timer

var game_over_sound : AudioStreamPlayer

var squid_ui : Node

var score = 0

func _input(event):
	if event.is_action_pressed("quit_game"):
		get_tree().quit()

func _ready():
	player = $Player
	spawn = $StartPosition
	squid_timer = $SquidTimer
	score_timer = $ScoreTimer
	start_timer = $StartTimer
	squid_spawn = $SquidPath/SquidSpawn
	squid_ui = $SquidUI
	game_over_sound = $GameOverSound
	
	squid_timer_initial_wait_time = squid_timer.wait_time
	
func new_game():
	score = 0
	get_tree().call_group(SQUID_GROUP, "queue_free")
	player.restart(spawn.position)
	start_timer.start()
	squid_ui.update_score(score)
	squid_ui.show_get_ready()
	squid_timer.wait_time = squid_timer_initial_wait_time
	
func game_over():
	squid_timer.stop()
	score_timer.stop()
	squid_ui.show_game_over()
	game_over_sound.play()
	
func _on_squid_timer_timeout():
	var squid = squid_scene.instantiate()
	
	squid_spawn.progress_ratio = randf()
	squid.position = squid_spawn.position
	
	var direction = squid_spawn.rotation + PI / 2
	direction += deg_to_rad(randf_range(-squid_rotation_offset, squid_rotation_offset))
	squid.rotation = direction
	
	var velocity = Vector2(randf_range(min_squid_speed, max_squid_speed), 0.0)
	squid.linear_velocity = velocity.rotated(squid.rotation)
	
	add_child(squid)

func _on_score_timer_timeout():
	score += 1
	squid_ui.update_score(score)
	squid_timer.wait_time = max(squid_timer.wait_time - squid_timer_decrease, min_squid_timer)

func _on_start_timer_timeout():
	squid_timer.start()
	score_timer.start()
