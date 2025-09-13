extends Enemy

func _physics_process(delta: float) -> void:
	handle_movement(delta)

func handle_movement(delta: float) -> void:
	apply_enemy_gravity(delta)
	if is_on_floor():
		velocity.x = lerpf(velocity.x, 0, delta * 10)
	move_and_slide()
