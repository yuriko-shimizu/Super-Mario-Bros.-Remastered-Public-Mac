class_name SettingObjectNode
extends Node

@export var setting_key := "difficulty"
@export var setting_title := ""

@export var valid_value := 1

@export var nodes_to_delete: Array[Node] = []

func _ready() -> void:
	if Settings.file[setting_key][setting_title] == valid_value:
		for i in nodes_to_delete:
			i.queue_free()
	else:
		queue_free()
