extends Enemy

var can_move := true

var angry := false

var can_turn := false

func _ready() -> void:
	$Sprite.play("Walk")

func _physics_process(_delta: float) -> void:
	if can_turn:
		$Sprite.scale.x = direction

func stomped_on(player: Player) -> void:
	AudioManager.play_sfx("enemy_stomp", global_position)
	can_move = false
	DiscoLevel.combo_amount += 1
	$BasicEnemyMovement.can_move = false
	player.enemy_bounce_off()
	$Sprite.play("Stomped")
	$Hitbox.queue_free()
	await get_tree().create_timer(0.5, false).timeout
	queue_free()

func damage(object: Node2D) -> void:
	if angry:
		die_from_object(object)
		$ScoreNoteSpawner.spawn_note(200)
		return
	AudioManager.play_sfx("kick", global_position)
	velocity.y = -150
	direction = sign(global_position.x - object.global_position.x)
	angry = true
	$Sprite.play("Angry")
	$BasicEnemyMovement.move_speed *= 2
