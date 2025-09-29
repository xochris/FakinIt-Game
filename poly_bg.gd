extends Node2D

@export var rseed: int = 0
@export var num_dots: int = 50

func _ready():
	var r := RandomNumberGenerator.new()
	r.seed = rseed

	for i in num_dots:
		var dot = preload("res://dot.tscn").instantiate()
		dot.init_rand(r, _play_area_extents())

		add_child(dot)


func _play_area_extents() -> Vector2:
	return $PlayArea/CollisionShape2D.shape.extents

func _on_play_area_area_exited(area):
	var extents := _play_area_extents()
	var p: Vector2 = area.position
	
	if p.x < -extents.x:
		p.x += extents.x * 2
	elif p.x > extents.x:
		p.x -= extents.x * 2

	if p.y < -extents.y:
		p.y += extents.y * 2
	elif p.y > extents.y:
		p.y -= extents.y * 2

	area.position = p

# Thanks to @binary_soup on YT for the guide!
