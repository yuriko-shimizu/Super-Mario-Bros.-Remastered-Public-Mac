class_name LedgeDetectionCast
extends RayCast2D

@export var floor_normal := Vector2.UP
@export var ray_length := 24
var floor_direction := 1
var direction := 1

## Hypotenuse = floor_angle
## Opposite = ???
## Adjacent = position.x


func _physics_process(_delta: float) -> void:
	target_position.y = ray_length
	if floor_normal.x > 0:
		floor_direction = 1
	elif floor_normal.x < 0:
		floor_direction = -1
	else:
		position.y = -(ray_length / 2.0)
		return
	position.y = ((-floor_normal.y * (position.x)) * (floor_direction)) - (ray_length / 2.0)
