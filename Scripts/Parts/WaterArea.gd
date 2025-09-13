class_name WaterArea
extends Area2D

@export var max_height := -158

func _physics_process(_delta: float) -> void:
	for i in get_tree().get_nodes_in_group("Players"):
		if i.global_position.y <= max_height:
			i.velocity.y += 20
		i.global_position.y = clamp(i.global_position.y, max_height - 4, INF)
