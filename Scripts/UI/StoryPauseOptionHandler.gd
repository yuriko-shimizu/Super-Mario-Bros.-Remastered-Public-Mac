extends Node

func restart_level() -> void:
	Global.player_power_states = "0000"
	Global.checkpoint_passed = false
	Level.first_load = true
	Global.speed_run_timer = 0
	Global.marathon_mode = false
	Global.marathon_practice = false
	Global.speed_run_timer_enabled = false
	Global.boo_race = false
	Global.speed_run_timer_active = false
	Global.reset_values()
	AudioManager.main_level_music.stop()
	Global.death_load = true
	Global.current_level.reload_level()

func quit_to_menu() -> void:
	Global.transition_to_scene("res://Scenes/Levels/TitleScreen.tscn")
