extends EntityGenerator

@export_range(1, 8, 1) var wind_force := 4
@export_enum("Right" , "Left") var wind_direction := 0

func _ready() -> void:
	await get_tree().create_timer(0.1, false).timeout
	get_parent().move_child(self, 0)

func _physics_process(delta: float) -> void:
	[$CanvasLayer/Left, $CanvasLayer/Right][wind_direction].show()
	for i in [$CanvasLayer/Left/Particles, $CanvasLayer/Right/Particles]:
		i.emitting = active
		i.speed_scale = float(wind_force) / 4
		i.amount = wind_force * 16
	if active:
		for i: Player in get_tree().get_nodes_in_group("Players"):
			if i.spring_bouncing == false and i.is_on_wall() == false and i.state_machine.state.name == "Normal":
				i.simulated_velocity.x = wind_force * [1, -1][wind_direction]
				i.global_position.x += ((wind_force * 10) * [1, -1][wind_direction]) * delta
		if $SFX.is_playing() == false:
			$SFX.play()
	else:
		$SFX.stop()

func activate() -> void:
	if not active:
		active = true

func deactivate_all_generators() -> void:
	for i in get_tree().get_nodes_in_group("EntityGenerators"):
		i.active = false
		
