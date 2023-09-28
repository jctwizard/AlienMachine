extends RigidBody2D

var sprite : AnimatedSprite2D

func _ready():
	sprite = $Sprite
	
	var squid_types = sprite.sprite_frames.get_animation_names()
	sprite.play(squid_types[randi() % squid_types.size()]) 

func _on_visible_notifier_screen_exited():
	queue_free()
