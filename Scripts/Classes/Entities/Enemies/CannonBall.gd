extends Enemy

var direction_vector := Vector2.UP

const MOVE_SPEED := 70.0

func _physics_process(delta: float) -> void:
	global_position += direction_vector * MOVE_SPEED * delta
