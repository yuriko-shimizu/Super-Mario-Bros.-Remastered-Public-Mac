class_name ExtraBGM
extends Node

@export var extra_track: JSON = null

func _ready() -> void:
	if Settings.file.audio.extra_bgm == 1:
		owner.music = extra_track
