extends Enemy

@export var held_scene: PackedScene = null

func stomped_on(player: Player) -> void:
	player.enemy_bounce_off()
	AudioManager.play_sfx("enemy_stomp", global_position)
	summon_held()

func summon_held() -> Node:
	var node = held_scene.instantiate()
	node.global_position = global_position
	node.direction = direction
	if $TrackJoint.is_attached:
		get_parent().owner.add_sibling(node)
	else:
		add_sibling(node)
	queue_free()
	return node

func fireball_hit(fireball: Node2D) -> void:
	var held = summon_held()
	held.kick(fireball)
