extends Node2D


@export_file("*.tscn") var scene := ""

func begin() -> void:
	$CameraRightLimit._enter_tree()
	await AudioManager.music_override_player.finished
	await get_tree().create_timer(1, false).timeout
	if Global.current_game_mode == Global.GameMode.MARATHON or Global.current_game_mode == Global.GameMode.MARATHON_PRACTICE:
		Global.open_marathon_results()
		return
	$StaticBody2D.queue_free()
	await get_tree().create_timer(2, false).timeout
	Global.transition_to_scene(scene)
