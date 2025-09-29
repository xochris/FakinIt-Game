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
		

# var origin_polygons : PackedVector2Array = PackedVector2Array()
# @export var intensity := 6.0
# @export var duration := 0.6

# var curtime: float = 0.0
# var total_time: float = 0.0
# var from_offsets : Array = []
# var to_offsets : Array = []
# var rng : RandomNumberGenerator

# @onready var button = get_parent().get_parent()

# func _ready() -> void:
#     z_index = -1
#     # ensure we have a base polygon
#     if polygon.empty():
#         polygon = PackedVector2Array([
#             Vector2(0,0), Vector2(100,0), Vector2(100,40), Vector2(0,40)
#         ])

#     # size based on parent button (supports Control.rect_size)
#     var size = Vector2(100, 40)
#     if button:
#         if "rect_size" in button:
#             size = button.rect_size
#         elif button.has_method("get_size"):
#             size = button.get_size()

#     var pad = 10
#     polygon = PackedVector2Array([
#         Vector2(-pad, -pad),
#         Vector2(size.x + pad, -pad),
#         Vector2(size.x + pad, size.y + pad),
#         Vector2(-pad, size.y + pad)
#     ])

#     # store original vertex positions
#     origin_polygons = PackedVector2Array(polygon)

#     # RNG and initial offset arrays
#     rng = RandomNumberGenerator.new()
#     rng.randomize()
#     from_offsets = _zero_offsets()
#     to_offsets = _random_offsets(intensity)


# func _physics_process(delta: float) -> void:
#     if origin_polygons.size() == 0:
#         return

#     curtime += delta
#     total_time += delta
#     var t := 0.0
#     if duration > 0.0:
#         t = clamp(curtime / duration, 0.0, 1.0)

#     # when cycle completes, shift offsets and pick a new target
#     if t >= 1.0:
#         curtime = 0.0
#         from_offsets = _copy_array(to_offsets)
#         to_offsets = _random_offsets(intensity)
#         t = 0.0

#     # interpolate offsets and apply to polygon vertices
#     for i in range(origin_polygons.size()):
#         var base_pos : Vector2 = origin_polygons[i]
#         var fo : Vector2 = from_offsets[i]
#         var to : Vector2 = to_offsets[i]
#         var interp : Vector2 = fo.linear_interpolate(to, t)
#         polygon[i] = base_pos + interp

#     # subtle rotation tilt using total_time
#     rotation = sin(total_time * TAU * 0.25) * 0.03


# # helpers

# func _zero_offsets() -> Array:
#     var arr := []
#     for i in range(origin_polygons.size()):
#         arr.append(Vector2.ZERO)
#     return arr

# func _random_offsets(max_value: float) -> Array:
#     var arr := []
#     for i in range(origin_polygons.size()):
#         arr.append(_random_offset(max_value))
#     return arr

# func _random_offset(max_value: float) -> Vector2:
#     if max_value <= 0.0:
#         return Vector2.ZERO
#     return Vector2(rng.randf_range(-max_value, max_value), rng.randf_range(-max_value, max_value))

# func _copy_array(src: Array) -> Array:
#     var out := []
#     for v in src:
#         out.append(v)
#     return out
