class_name ChallengeNodes
extends Node

@export var nodes_to_delete: Array[Node]
@export var no_report := false
@export var force_on := false

func _ready() -> void:
	if force_on and Global.current_game_mode == Global.GameMode.NONE:
		Global.current_game_mode = Global.GameMode.CHALLENGE
	if Global.current_game_mode != Global.GameMode.CHALLENGE:
		queue_free()
	else:
		ChallengeModeHandler.red_coins = 0
		for i in 5:
			if ChallengeModeHandler.is_coin_collected([0, 1, 2, 3, 4][i]):
				ChallengeModeHandler.red_coins += 1
		for i in nodes_to_delete:
			if i != null:
				i.queue_free()
