class_name AllCoinsCollectedCheck
extends Node

signal checked

func check() -> void:
	if get_tree().get_nodes_in_group("Coins").is_empty() and Global.current_game_mode == Global.GameMode.CHALLENGE:
		await get_tree().create_timer(1, false).timeout
		$CanvasLayer.show()
		AudioManager.set_music_override(AudioManager.MUSIC_OVERRIDES.COIN_HEAVEN_BONUS, 99, false, false)
		await get_tree().create_timer(1, false).timeout
		await score_tween()
		await get_tree().create_timer(1, false).timeout
	await get_tree().process_frame
	checked.emit()

func score_tween() -> void:
	Global.tallying_score = true
	Global.get_node("ScoreTally").play()
	var tween = create_tween()
	tween.tween_property(Global, "score", Global.score + 10000, 2)
	await tween.finished
	Global.get_node("ScoreTallyEnd").play()
	Global.get_node("ScoreTally").stop()
	Global.tallying_score = false
	return
