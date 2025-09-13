class_name ExplosionDetection
extends Node

@export var hitbox: Area2D = null
signal explosion_entered(explosion: Node2D)

func _ready() -> void:
	if hitbox != null:
		hitbox.area_entered.connect(area_entered)

func area_entered(area: Area2D) -> void:
	if area.owner is Explosion:
		explosion_entered.emit(area.owner)
