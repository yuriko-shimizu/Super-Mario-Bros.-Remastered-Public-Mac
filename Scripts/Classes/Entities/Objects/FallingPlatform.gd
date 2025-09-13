extends AnimatableBody2D

func _physics_process(delta: float) -> void:
	if $PlayerDetect.get_overlapping_areas().any(is_player):
		global_position.y += 96 * delta

func is_player(area: Area2D) -> bool:
	if area.owner is Player:
		return area.owner.is_on_floor() and area.owner.global_position.y - 4 <= global_position.y
	return false
