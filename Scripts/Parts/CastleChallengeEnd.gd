extends Node2D

@export var play_end_music := false
var can_menu := false
const ENDING = preload("res://Assets/Audio/BGM/Ending.mp3")
func begin() -> void:
	for player in get_tree().get_nodes_in_group("Players"):
		player.z_index = -2
	$CameraRightLimit._enter_tree()
	await get_tree().create_timer(1, false).timeout
	Global.tally_time()
	await get_tree().create_timer(6, false).timeout
	Global.transition_to_scene("res://Scenes/Levels/ChallengeModeCastleResults.tscn")
