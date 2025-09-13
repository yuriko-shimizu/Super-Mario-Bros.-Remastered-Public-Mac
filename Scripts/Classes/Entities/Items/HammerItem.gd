extends PowerUpItem

func _physics_process(delta: float) -> void:
	pass

func on_player_entered(player: Player) -> void:
	player.hammer_get()
	queue_free()
