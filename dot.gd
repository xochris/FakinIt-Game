extends Area2D
class_name Dot

@export var velocity: Vector2
@export var speed := 30

var nearby_dots := []

func init_rand(r : RandomNumberGenerator, screen_extents : Vector2):
	var x := screen_extents.x * 2 * r.randf() - screen_extents.x
	var y := screen_extents.y * 2 * r.randf() - screen_extents.y

	position = Vector2(x,y)
	velocity = Vector2(r.randf(), r.randf())

func _process(delta):
	position += velocity * speed * delta
	queue_redraw()

func _draw():
	for dot in nearby_dots:
		var to_pos : Vector2 = to_local(dot.position)
		var dist := to_pos.length()
		var max_dist: float = $CollisionShape2D.shape.radius * 2

		if dist > max_dist:
			continue # skip drawing if too far away

		var c := Color.WHITE
		c.a = 1 - dist / max_dist # alpha = 0 when at min distance and when at max distance we will get 1, do 1 - to do inverse of it. (fade effect)
		draw_line(Vector2(), to_pos, c, 2.0)
	draw_circle(Vector2(), 1.0, Color.WHITE)

func _on_area_entered(area):
	if area is Dot:
		nearby_dots.append(area)

func _on_area_exited(area):
	if area is Dot:
		nearby_dots.erase(area)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# @binary_soup on YT, thank you for the guide!