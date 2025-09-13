class_name IcicleDetection
extends Node

@export var hitbox: Area2D = null

signal icicle_detected(icicle: Icicle)

func _ready() -> void:
	if hitbox != null:
		hitbox.area_entered.connect(area_entered)

func area_entered(area: Area2D) -> void:
	if area.owner is Icicle:
		if area.owner.falling:
			icicle_detected.emit(area.owner)
