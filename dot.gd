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

func _draw():
	draw_circle(Vector2(), 1.0, Color.WHITE)

func _process(delta):
	position += velocity * speed * delta
	queue_redraw()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
