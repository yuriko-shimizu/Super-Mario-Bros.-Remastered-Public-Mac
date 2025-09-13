extends Node2D

func _ready() -> void:
	Global.level_editor.level_start.connect(move_players)

func move_players() -> void:
	for i in get_tree().get_nodes_in_group("Players"):
		i.global_position = global_position
