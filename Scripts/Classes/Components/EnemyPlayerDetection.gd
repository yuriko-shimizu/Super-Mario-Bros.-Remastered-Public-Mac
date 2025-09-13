class_name EnemyPlayerDetection
extends Node

@export var hitbox: Area2D = null

@export var height := 4

signal player_hit(player: Player)
signal player_stomped_on(player: Player)
signal invincible_player_hit(player: Player)

func _ready() -> void:
	hitbox.area_entered.connect(area_entered)

func area_entered(area: Area2D) -> void:
	if area.owner is Player:
		player_entered(area.owner)

func player_entered(player: Player) -> void:
	if player.is_invincible or player.has_hammer:
		invincible_player_hit.emit(player)
	elif (player.velocity.y >= 15 or (player.global_position.y + height < owner.global_position.y)) and player.in_water == false:
		player_stomped_on.emit(player)
	else:
		player_hit.emit(player)
