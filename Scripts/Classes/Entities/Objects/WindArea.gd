extends Area2D

@export var wind_force := 30

func _ready() -> void:
	await get_tree().create_timer(0.1, false).timeout
	get_parent().move_child(self, 0)

func _physics_process(delta: float) -> void:
	for i in get_overlapping_areas():
		if i.owner is Player:
			if i.owner.spring_bouncing == false and i.owner.is_on_wall() == false and i.owner.state_machine.state.name == "Normal":
				i.owner.global_position.x += wind_force * delta
	var active := get_overlapping_areas().any(func(area: Area2D) -> bool: return area.owner is Player)
	$CanvasLayer/Control/Particles.emitting = active
	if active and $SFX.is_playing() == false:
		$SFX.play()
	elif not active:
		$SFX.stop()
