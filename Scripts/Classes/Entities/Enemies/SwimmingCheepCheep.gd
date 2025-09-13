extends Enemy

@export var move_speed := 20

@export_enum ("Straight", "Wavey", "Random") var movement_type := 2

func _ready() -> void:
	if movement_type == 2:
		if [0, 1].pick_random() == 1:
			$WaveAnimations.play("Wave")
		else:
			$WaveAnimations.play("RESET")
	elif movement_type == 1:
		$WaveAnimations.play("Wave")
	else:
		$WaveAnimations.play("RESET")

func _physics_process(delta: float) -> void:
	global_position.x += (move_speed * direction) * delta
