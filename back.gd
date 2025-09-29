extends Button

@export var pulse_speed := 2.0  # how fast it pulses
@export var min_opacity := 0.4  # how transparent it gets at the lowest point

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	# oscillate between min_opacity and 1.0
	var alpha = lerp(min_opacity, 1.0, (sin(Time.get_ticks_msec() / 1000.0 * pulse_speed) + 1.0) / 2.0)
	modulate.a = alpha
	pass
