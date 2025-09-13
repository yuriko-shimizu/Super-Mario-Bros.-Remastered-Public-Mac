class_name AnimationPauser
extends Node

@export var animation_player: AnimationPlayer = null

@export var paused := false

signal just_paused
signal resumed

func _process(_delta: float) -> void:
	animation_player.speed_scale = int(not paused)

func on_switch_hit() -> void:
	paused = not paused
	if paused: just_paused.emit()
	else: resumed.emit()
