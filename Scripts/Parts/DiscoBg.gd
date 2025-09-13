extends Parallax2D

var level_bpm := 120

@export var level := 0.5

var is_star := false

var beats := -1

var tween: Tween = null

func _ready() -> void:
	modulate.a = 0
	AudioManager.music_beat.connect(on_timeout)
	on_timeout()

func _physics_process(delta: float) -> void:
	scroll_offset.y = lerpf(scroll_offset.y, lerpf(128, 0, level), delta * 5)
	modulate.a = lerpf(modulate.a, lerpf(0, 1, level), delta * 5)
	$TextureRect.position.y = move_toward($TextureRect.position.y, -64, delta * (level_bpm / 10))


func on_timeout(idx := 0) -> void:
	beats = idx
	if is_star == false:
		tween_back()
		if beats % 4 == 0:
			$AudioStreamPlayer.pitch_scale = 2
		else:
			$AudioStreamPlayer.pitch_scale = 1
		$AudioStreamPlayer.play()




func tween_back() -> void:
	if tween != null:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($TextureRect, "position:y", -160, 0.05)


func on_starttimeout() -> void:
	if is_star:
		tween_back()
