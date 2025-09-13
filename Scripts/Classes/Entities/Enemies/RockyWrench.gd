extends Enemy

@export var can_stomp := false
const WRENCH_PROJECTILE = preload("uid://p42vcj0qmhxl")
var count := 0

func _ready() -> void:
	$Timer.start()

func on_player_stomped_on(player: Player) -> void:
	if can_stomp:
		$GibSpawner.stomp_die(player)

func on_timeout() -> void:
	if is_on_floor() == false:
		return
	direction = sign(get_tree().get_first_node_in_group("Players").global_position.x - global_position.x + 1)
	$Sprite.scale.x = direction
	if count == 0:
		$Animations.play("PeekOut")
		$Sprite.play("Idle")
	else:
		count = -1
		$Sprite.play("Aim")
		$Animations.play("Throw")
	await $Animations.animation_finished
	$Timer.start()
	count += 1

func throw_wrench() -> void:
	$Sprite.play("Throw")
	var node = WRENCH_PROJECTILE.instantiate()
	node.global_position = $Sprite/Wrench.global_position
	node.direction = direction
	add_sibling(node)
