extends Node2D

@export var item: PackedScene = preload("uid://bumvqjhs2xxka")

@export_range(0, 8, 1) var head_angle := 0
@export_range(0, 4, 1) var stand_angle := 0

var amount := 0

func _ready() -> void:
	$Timer.start()

func shoot() -> void:
	if amount >= 3 or $Head/Raycast.is_colliding():
		return
	var node = item.instantiate()
	var direction_vector = [Vector2.UP, Vector2(1, -1), Vector2.RIGHT, Vector2(1, 1), Vector2.DOWN, Vector2(-1, 1), Vector2.LEFT, Vector2(-1, -1), Vector2.UP][head_angle]
	node.set("direction_vector", direction_vector)
	node.set("velocity", 100 * direction_vector)
	if direction_vector.x != 0:
		node.set("direction", sign(direction_vector.x))
	node.global_position = global_position
	if item.resource_path != "res://Scenes/Prefabs/Entities/Objects/CannonBall.tscn":
		node.global_position += direction_vector * 4
	node.tree_exited.connect(func(): amount -= 1)
	amount += 1
	AudioManager.play_sfx("cannon", global_position)
	add_sibling(node)
