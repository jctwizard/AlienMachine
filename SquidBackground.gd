extends ColorRect

@export var lerp_duration = 10.0
@export var gradient : Gradient
var current_lerp_time = 0

func _ready():
	current_lerp_time = randf_range(0, lerp_duration)
	update_colour()

func _process(delta):
	current_lerp_time += delta
	
	if (current_lerp_time > lerp_duration):
		current_lerp_time = 0
		
	update_colour()
	
func update_colour():
	color = gradient.sample(current_lerp_time / lerp_duration);
