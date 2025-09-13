class_name BlockHitter
extends Node

@export var hitbox: Area2D = null
@export var can_break_bricks := false
@export var enabled := true:
	set(value):
		enabled = value
		set_physics_process(value)

signal block_hit(block: Block)

func _ready() -> void:
	hitbox.set_collision_mask_value(3, true)

func _physics_process(_delta: float) -> void:
	for i in hitbox.get_overlapping_bodies():
		if i is Block and i.global_position.y < owner.global_position.y:
			i.shell_block_hit.emit(self)
			block_hit.emit(i)
			if i is BrickBlock:
				if i.item == null:
					i.destroy()
