extends Enemy

const MOVE_SPEED := 32

var can_move := true
const DRY_BONES_DESTRUCTION_PARTICLES = preload("uid://bhs5ly6bbaahk")
func _physics_process(_delta: float) -> void:
	$Sprite.scale.x = direction

func stomped_on(player: Player) -> void:
	player.enemy_bounce_off(false)
	$Sprite.play("Crumble")
	AudioManager.play_sfx("dry_bones_crumble", global_position)
	$BasicEnemyMovement.can_move = false
	set_collision_layer_value(5, false)
	set_collision_mask_value(5, false)
	set_collision_mask_value(6, false)
	$Hitbox/Shape.set_deferred("disabled", true)
	await get_tree().create_timer(3, false).timeout
	$ShakeAnimation.play("Shake")
	await get_tree().create_timer(1, false).timeout
	$Sprite.play("GetUp")
	$ShakeAnimation.play("RESET")
	await $Sprite.animation_finished
	$BasicEnemyMovement.can_move = true
	$Hitbox/Shape.set_deferred("disabled", false)
	set_collision_layer_value(5, true)
	set_collision_mask_value(5, true)
	set_collision_mask_value(6, true)
	$Sprite.play("Walk")

func summon_particle() -> void:
	var particle = DRY_BONES_DESTRUCTION_PARTICLES.instantiate()
	particle.global_position = global_position + Vector2(0, -10)
	add_sibling(particle)
	AudioManager.play_sfx("dry_bones_crumble", global_position)
