extends StaticBody2D


func on_player_entered(_player: Player) -> void:
	$Sprite.play("Turn")
	await get_tree().physics_frame
	$Collision.set_deferred("disabled", true)

func on_player_exited(_player: Player) -> void:
	$Sprite.play("Idle")
	$Collision.set_deferred("disabled", false)
