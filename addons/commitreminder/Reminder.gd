@tool
extends PanelContainer

var timer_active := false


func _process(_delta: float) -> void:
	if timer_active:
		var time_left = $Timer.time_left
		$VBoxContainer/TimerCountdown.text = gen_time_string(format_time(time_left)) + " Left..."

func format_time(time_time := 0.0) -> Dictionary:
	var mils = abs(fmod(time_time, 1) * 100)
	var secs = abs(fmod(time_time, 60))
	var mins = abs(time_time / 60)
	return {"mils": int(mils), "secs": int(secs), "mins": int(mins)}

func gen_time_string(timer_dict := {}) -> String:
	return str(int(timer_dict["mins"])).pad_zeros(2) + ":" + str(int(timer_dict["secs"])).pad_zeros(2) + ":" + str(int(timer_dict["mils"])).pad_zeros(2)

func timer_finished() -> void:
	for i in 3:
		$AudioStreamPlayer.play()
		await get_tree().create_timer(1).timeout
	start_timer()

func start_timer() -> void:
	print("ahh")
	if not timer_active:
		$Timer.wait_time = $VBoxContainer/HBoxContainer/SpinBox.value * 60
		$Timer.start()
		$VBoxContainer/Inactive.hide()
		$VBoxContainer/TimerCountdown.show()
		timer_active = true
	else:
		timer_active = false
		$Timer.stop()
		$VBoxContainer/Inactive.show()
		$VBoxContainer/TimerCountdown.hide()
	$VBoxContainer/HBoxContainer/Start.text = "Start" if not timer_active else "Stop"


func on_pressed() -> void:
	print("FUCK")
