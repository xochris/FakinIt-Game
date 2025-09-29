extends Polygon2D


@onready var poly_left = $PolygonLeft

func _ready():
	poly_left.polygon = PackedVector2Array([
		Vector2(-50, -20),  # left
		Vector2(50, -20),   # right
		Vector2(50, 20),    # bottom-right
		Vector2(-50, 20)    # bottom-left
	])
