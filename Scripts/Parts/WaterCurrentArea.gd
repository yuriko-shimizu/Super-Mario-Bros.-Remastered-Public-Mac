extends Node2D

@export var strength := 3

func _ready() -> void:
	$Particles.amount = 32 * scale.x

func _physics_process(delta: float) -> void:
	for i in $Hitbox.get_overlapping_areas():
		if i.owner is Player:
			for x in strength:
				i.owner.apply_gravity(delta * 1.5)
