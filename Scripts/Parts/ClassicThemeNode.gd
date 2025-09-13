class_name ClassicThemeNode
extends Node

@export_enum("Overworld", "Underground", "Desert", "Snow", "Jungle", "Beach", "Garden", "Mountain", "Skyland", "Autumn", "Pipeland", "Space", "Underwater", "Volcano", "Castle") var classic_theme := "Overworld"
@export var nodes_to_delete: Array[Node] = []

func _ready() -> void:
	queue_free()
