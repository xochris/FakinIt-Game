extends RichTextLabel

@export var pulse_speed: float = 2.0      # Higher = faster pulse
@export var min_alpha: float = 0.5        # 0.5 = 50% opacity at lowest point

var t: float = 0.0

func _process(delta: float) -> void:
    t += delta * pulse_speed
    # Oscillate between 1.0 (100%) and min_alpha
    var alpha = lerp(min_alpha, 1.0, (sin(t) + 1.0) * 0.5)
    modulate.a = alpha