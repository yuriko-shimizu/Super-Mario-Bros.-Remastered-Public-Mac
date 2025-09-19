extends Node

var file := {
	"video": {
		"mode": 0,
		"size": 0,
		"vsync": 1,
		"drop_shadows": 1,
		"scaling": 0,
		"visuals": 0,
		"hud_size": 0, 
		"frame_limit" : 0,
	},
	"audio": {
		"master": 10.0,
		"music": 10.0,
		"sfx": 10.0,
		"athletic_bgm": 1,
		"extra_bgm": 1,
		"skid_sfx": 1,
		"extra_sfx": 0,
		"menu_bgm": 0
	},
	"game": {
		"campaign": "SMB1",
		"lang": "en",
		"character": "0000"
	},
	"keyboard":
	{
		"jump": "Z",
		"run": "X",
		"action": "X",
		"move_left": "Left",
		"move_right": "Right",
		"move_up": "Up",
		"move_down": "Down"
	},
	"controller":
	{
		"jump": 0,
		"run": 2,
		"action": 2,
		"move_left": "0,-1",
		"move_right": "0,1",
		"move_up": "1,-1",
		"move_down": "1,1"
	},
	"visuals":
	{
		"parallax_style": 2,
		"resource_packs": [Global.ROM_PACK_NAME],
		"modern_hud": 0,
		"rainbow_style": 0,
		"extra_bgs": 1,
		"bg_particles": 1,
		"transform_style": 0,
		"athletic_bgm": 1,
		"skid_sfx": 1,
		"text_shadows": 1,
		"bridge_animation": 0,
		"visible_timers": 0,
		"transition_animation": 0,
		"colour_pipes": 1
	},
	"difficulty":
	{
		"damage_style": 1,
		"checkpoint_style": 0,
		"inf_lives": 0,
		"flagpole_lives": 0,
		"game_over_behaviour": 0,
		"level_design": 0,
		"extra_checkpoints": 0,
		"back_scroll": 0,
		"time_limit": 1,
		"lakitu_style": 0
	}
}

const SETTINGS_DIR := "user://settings.cfg"

func _enter_tree() -> void:
	DirAccess.make_dir_absolute("user://resource_packs")
	load_settings()
	await get_tree().physics_frame
	apply_settings()
	TranslationServer.set_locale(Settings.file.game.lang)

func save_settings() -> void:
	var cfg_file = ConfigFile.new()
	for section in file.keys():
		for key in file[section].keys():
			cfg_file.set_value(section, key, file[section][key])
	cfg_file.set_value("game", "seen_disclaimer", true)
	cfg_file.set_value("game", "campaign", Global.current_campaign)
	cfg_file.save(SETTINGS_DIR)

func load_settings() -> void:
	if FileAccess.file_exists(SETTINGS_DIR) == false:
		save_settings()
	var cfg_file = ConfigFile.new()
	cfg_file.load(SETTINGS_DIR)
	for section in cfg_file.get_sections():
		for key in cfg_file.get_section_keys(section):
			file[section][key] = cfg_file.get_value(section, key)

func apply_settings() -> void:
	for i in file.video.keys():
		$Apply/Video.set_value(i, file.video[i])
	for i in file.audio.keys():
		$Apply/Audio.set_value(i, file.audio[i])
	if Settings.file.game.has("characters"):
		var idx := 0
		for i in Settings.file.game.characters:
			Global.player_characters[idx] = int(i)
			idx += 1
