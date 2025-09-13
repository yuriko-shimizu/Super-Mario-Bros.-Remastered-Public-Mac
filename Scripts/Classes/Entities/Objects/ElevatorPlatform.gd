extends StaticBody2D

@export var vertical_direction := 1
const MOVE_SPEED := 50
@export var top := -244

func _physics_process(delta: float) -> void:
	global_position.y += (MOVE_SPEED * delta) * vertical_direction
	global_position.y = wrap(global_position.y, top, 64)
