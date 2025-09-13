@tool
extends CollisionShape2D

@export var offset := Vector2.ZERO
@export var link: Node2D

func _ready() -> void:
	set_process(Engine.is_editor_hint())

func _process(_delta: float) -> void:
	update()

func update() -> void:
	var height_to_use = shape.size.y
	if link != null:
		height_to_use *= link.scale.y * link.scale.y
	position.y = -height_to_use / 2 * scale.y - offset.y
