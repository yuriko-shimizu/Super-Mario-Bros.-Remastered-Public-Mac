extends Block
const SPINNING_TURN_BLOCK = preload("uid://b8dalotrk2oci")
func on_block_hit(player: Player) -> void:
	if item != null:
		if mushroom_if_small:
			item = player_mushroom_check(player)
		dispense_item()
	else:
		spin()

func on_shell_block_hit(_shell: Shell) -> void:
	if item != null:
		dispense_item()
	else:
		spin()

func spin() -> void:
	await get_tree().create_timer(0.15, false).timeout
	var spinning = SPINNING_TURN_BLOCK.instantiate()
	spinning.position = position
	add_sibling(spinning)
	queue_free()
