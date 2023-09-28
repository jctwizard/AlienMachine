extends CanvasLayer

signal start_game

@export var game_over_text = "Game Over!"
@export var get_ready_text = "Get Ready!"

var message : Label
var message_timer : Timer
var start_button : Button
var score_label : Label

var start_text : String

# Called when the node enters the scene tree for the first time.
func _ready():
	message = $Message
	message_timer = $MessageTimer
	start_button = $StartButton
	score_label = $ScoreLabel
	
	start_text = message.text

func update_score(score):
	score_label.text = str(score)

func show_get_ready():
	show_message(get_ready_text)

func show_game_over():
	show_message(game_over_text)
	#Wait until the MessageTimer has counter down
	await message_timer.timeout
	
	show_message(start_text, false)
	
	await get_tree().create_timer(1.0).timeout
	
	start_button.show()

func show_message(text, use_timer = true):
	message.text = text
	message.show()
	
	if use_timer:
		message_timer.start()

func _on_message_timer_timeout():
	message.hide()

func _on_start_button_pressed():
	start_button.hide()
	start_game.emit()
