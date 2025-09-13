class_name LevelEditorToggleDetection
extends Node

signal toggled

signal level_start
signal editor_start

func _ready() -> void:
	await get_tree().physics_frame
	if is_instance_valid(Global.level_editor):
		Global.level_editor.level_start.connect(toggled.emit)
		Global.level_editor.level_start.connect(level_start.emit)
		Global.level_editor.editor_start.connect(editor_start.emit)
		Global.level_editor.editor_start.connect(toggled.emit)
