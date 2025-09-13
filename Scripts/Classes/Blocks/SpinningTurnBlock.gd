extends Node2D
const TURN_BLOCK = ("uid://bn651dli8j2rj")

var can_turn_back := false

func _ready() -> void:
	$Sprite.frame = 1

func _physics_process(_delta: float) -> void:
	if can_turn_back:
		if $PlayerDetectionArea.get_overlapping_areas().any(func(area: Area2D) -> bool: return area.owner is Player) == false:
			spawn_block()
			can_turn_back = false

func on_timeout() -> void:
	can_turn_back = true

func spawn_block() -> void:
	var block = load(TURN_BLOCK).instantiate()
	block.position = position
	add_sibling(block)
	queue_free()
