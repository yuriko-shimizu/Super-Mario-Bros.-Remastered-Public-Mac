@tool
extends CollisionPolygon2D

@export var offset := Vector2.ZERO
@export var height := 0.0

func _physics_process(_delta: float) -> void:
	update()

func update() -> void:
	var height_to_use = height
	position.y = -height_to_use / 2 * scale.y - offset.y
