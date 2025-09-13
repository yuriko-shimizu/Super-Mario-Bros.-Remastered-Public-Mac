@tool
extends EditorPlugin

const REMINDER = preload("uid://hbpket74t6f7")
var reminder

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	reminder = REMINDER.instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, reminder)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_control_from_docks(reminder)
	reminder.free()
