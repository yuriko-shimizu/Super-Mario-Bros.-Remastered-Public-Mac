extends Node2D

var can_kill := false

func _ready() -> void:
	await get_tree().create_timer(0.5, false).timeout
	can_kill = true

func _physics_process(delta: float) -> void:
	global_position.y -= 32 * delta
	if global_position.y < -176:
		queue_free()
	elif $WaterDetection.get_overlapping_bodies().is_empty() and can_kill:
		queue_free()
