extends PowerUpItem

func collect_item(_player: Player) -> void:
	AudioManager.play_sfx("clock_get", global_position)
	$Label/AnimationPlayer.play("Appear")
	Global.time = clamp(Global.time + 100, 0, 999)
	Global.score += 1000
