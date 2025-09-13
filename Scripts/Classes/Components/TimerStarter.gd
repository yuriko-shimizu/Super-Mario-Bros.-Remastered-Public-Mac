class_name TimerStarter
extends Node

func _ready() -> void:
	if Global.level_editor != null:
		Global.level_editor.level_start.connect(start_timers)
	start_timers()

func start_timers() -> void:
	for i in get_children():
		if i is Timer:
			i.start()
