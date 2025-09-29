extends Polygon2D

var origin_polygons : PackedVector2Array
@export var intensity := 1.0
@export var duration := 1


var curtime: float = 0.0
var target_offset : Array[Vector2]
var prepos
var frompos

@onready var button = get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = -1 #behind other elements
	if polygon.is_empty():
		polygon = PackedVector2Array([
			Vector2(0, 0),
			Vector2(100, 0),
			Vector2(100, 40),
			Vector2(0, 40)
		])

	var size = button.get_size() #size of button
	var pad = 10 # padding around button
	polygon = PackedVector2Array([
		Vector2(-pad, -pad),
		Vector2(size.x + pad, -pad),
		Vector2(size.x + pad, size.y + pad),
		Vector2(-pad, size.y + pad)
	])

	origin_polygons = polygon
	prepos = origin_polygons
	frompos = prepos
	target_offset = add_vector2array_offset(prepos, random_vector2array_offset(intensity))
	pass

func _physics_process(delta: float):
	curtime += delta
	if curtime >= duration:
		frompos = target_offset
		target_offset = add_vector2array_offset(prepos, random_vector2array_offset(intensity))
		curtime = 0.0

	for i in range(polygon.size()):
		var _tar = prepos[i] + target_offset[i]
		var t = curtime/duration
		polygon[i] = lerp(frompos[i], target_offset[i], t)
	
	# rotation = sin(curtime * TAU / duration) * 0.05
	pass


func add_vector2array_offset(base: Array[Vector2], add: Array[Vector2]) -> Array[Vector2]:
	var ret : Array[Vector2]

	for i in base.size():
		ret.insert(i, base[i] + add[i])
	return ret


func random_offset(max_value: float) -> Vector2:
	return Vector2(randf_range(-max_value, max_value), randf_range(-max_value, max_value))


func random_vector2array_offset(max_value: float) -> Array[Vector2]:
	var arrVector2 : Array[Vector2]

	for i in origin_polygons.size():
		arrVector2.insert(i, random_offset(max_value))
	return arrVector2
		
