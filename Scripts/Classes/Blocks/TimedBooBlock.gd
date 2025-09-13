class_name TimedBooBlock
extends Block

var time := 3
var active := false

static var main_block = null

static var can_tick := true:
	set(value):
		can_tick = value

func _ready() -> void:
	main_block = self
	$Timer.start()

func on_timeout() -> void:
	if can_tick == false or BooRaceHandler.countdown_active: return
	time = clamp(time - 1, 0, 3)
	if main_block == self:
		if time <= 0:
			get_tree().call_group("BooBlocks", "on_switch_hit")
		elif time < 3:
			AudioManager.play_global_sfx("timer_beep")
	if active:
		$Sprite.play("On" + str(time))
	else:
		$Sprite.play("Off" + str(time))

func block_hit() -> void:
	if not can_hit:
		return
	can_hit = false
	get_tree().call_group("BooBlocks", "on_switch_hit")
	await get_tree().create_timer(0.25, false).timeout
	can_hit = true

func _exit_tree() -> void:
	can_tick = true

func on_switch_hit() -> void:
	AudioManager.play_global_sfx("switch")
	$Timer.stop()
	time = 4
	active = not active
	if active:
		$Sprite.play("BlueToRed")
	else:
		$Sprite.play("RedToBlue")
	await $Sprite.animation_finished
	$Timer.start()
	time = 4
	on_timeout()
