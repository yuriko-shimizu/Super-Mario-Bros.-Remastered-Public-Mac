@tool
class_name LevelGuide
extends Sprite2D

func _ready() -> void:
	if Engine.is_editor_hint() == false:
		queue_free()
	else:
		position = Vector2(-256, -208)
		centered = false
		modulate.a = 0.5
