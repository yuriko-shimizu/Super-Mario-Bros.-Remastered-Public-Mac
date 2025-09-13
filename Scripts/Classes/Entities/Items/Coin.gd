extends Node2D
const COIN_SPARKLE = preload("res://Scenes/Prefabs/Particles/CoinSparkle.tscn")

@export var spinning_coin_scene: PackedScene = null

signal collected

func area_entered(area: Area2D) -> void:
	if area.owner is Player:
		collect()

func collect() -> void:
	collected.emit()
	Global.coins += 1
	DiscoLevel.combo_meter += 10
	Global.score += 200
	AudioManager.play_sfx("coin", global_position)
	queue_free()

func summon_block_coin() -> void:
	var node = spinning_coin_scene.instantiate()
	node.global_position = global_position
	add_sibling(node)
	queue_free()

func summon_particle() -> void:
	var node = COIN_SPARKLE.instantiate()
	node.global_position = global_position
	add_sibling(node)
