extends Node2D

@export var reset_pos := Vector2.ZERO

signal player_teleported

func on_player_entered(_player: Player) -> void:
	if get_child_count() <= 1:
		for i in get_tree().get_nodes_in_group("Players"):
			teleport_player(i)
		return
	for i in get_children():
		if i is PickAPathPoint:
			if not i.crossed:
				for x in get_tree().get_nodes_in_group("Players"):
					teleport_player(x)
				return
	queue_free()

func teleport_player(player: Player) -> void:
	for i in get_children():
		if i is PickAPathPoint:
			i.crossed = false
	player.teleport_player(reset_pos)
	player_teleported.emit()
