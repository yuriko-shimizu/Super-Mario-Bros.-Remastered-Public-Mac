class_name CastleVisual
extends Node2D

@export var sprite: Sprite2D = null

var use_sprite := false

func _process(_delta: float) -> void:
	$Tiles.visible = not use_sprite
	$Sprite.visible = use_sprite
