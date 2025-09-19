extends Node

const SAVE_DIR := "user://saves/CAMPAIGN.sav"

var visited_levels := "1000000000000000000000000000000010000000000000000000"

var current_file := {}

const SAVE_TEMPLATE := {
	"World": 1,
	"Level": 1,
	"Lives": 3,
	"Coins": 0,
	"Score": 0,
	"GameWin": false,
	"PowerStates": "0000",
	"LevelsVisited": "1000000000000000000000000000000000000000000000000000",
	"BestAnyTime": 0.0,
	"BestWarplessTime": 0.0,
	"ClearedBooLevels": "00000000",
	"ChallengeScores": [
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0]
	],
	"RedCoins": [
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0],
		[0.0, 0.0, 0.0, 0.0]
	],
	"BooBestTimes": [
		-1.0, -1.0, -1.0, -1.0,
		-1.0, -1.0, -1.0, -1.0
	],
	"HighScore": 0,
	"ExtraWorldWin": false
}


func _ready() -> void:
	verify_saves()
	load_achievements()

func load_save(campaign := "SMB1") -> Dictionary:
	if FileAccess.file_exists(SAVE_DIR.replace("CAMPAIGN", campaign)) == false:
		write_save(campaign)
	var file = FileAccess.open(SAVE_DIR.replace("CAMPAIGN", campaign), FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	print(file.get_as_text())
	current_file = json
	file.close()
	return json

func verify_saves() -> void:
	for campaign in Global.CAMPAIGNS:
		if FileAccess.file_exists(SAVE_DIR.replace("CAMPAIGN", campaign)) == false:
			write_save(campaign, true)

func write_save(campaign: String = Global.current_campaign, force := false) -> void:
	if Global.debugged_in and not force:
		return
	var save = null
	DirAccess.make_dir_recursive_absolute("user://saves")
	DirAccess.make_dir_recursive_absolute("user://resource_packs")
	DirAccess.make_dir_recursive_absolute("user://custom_characters")
	DirAccess.make_dir_recursive_absolute("user://custom_levels")
	var save_json = {}
	var path = "user://saves/" + campaign + ".sav"
	if FileAccess.file_exists(path):
		save = FileAccess.open("user://saves/" + campaign + ".sav", FileAccess.READ)
		save_json = JSON.parse_string(save.get_as_text())
		save.close()
	else:
		save_json = SAVE_TEMPLATE.duplicate(true)
	match Global.current_game_mode:
		Global.GameMode.CAMPAIGN:
			if Global.high_score < Global.score:
				Global.high_score = Global.score
			save_json["World"] = Global.world_num
			save_json["Level"] = Global.level_num
			save_json["Coins"] = Global.coins
			save_json["Score"] = Global.score
			save_json["GameWin"] = Global.game_beaten
			save_json["PowerStates"] = Global.player_power_states
			save_json["LevelsVisited"] = visited_levels
			save_json["HighScore"] = Global.high_score
			save_json["ExtraWorldWin"] = Global.extra_worlds_win
		Global.GameMode.CHALLENGE:
			save_json["ChallengeScores"] = ChallengeModeHandler.top_challenge_scores
			save_json["RedCoins"] = ChallengeModeHandler.red_coins_collected
		Global.GameMode.BOO_RACE:
			save_json["ClearedBooLevels"] = BooRaceHandler.cleared_boo_levels
			save_json["BooBestTimes"] = BooRaceHandler.best_times
		Global.GameMode.MARATHON:
			save_json["BestAnyTime"] = SpeedrunHandler.marathon_best_any_time
			save_json["BestWarplessTime"] = SpeedrunHandler.marathon_best_warpless_time
		_:
			pass
	if campaign == "SMBANN":
		save_json["Ranks"] = DiscoLevel.level_ranks
	write_save_to_file(save_json, path)

func write_save_to_file(json := {}, path := "") -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(json, "\t", false, false))
	file.close()

func apply_save(json := {}) -> void:
	Global.world_num = clamp(json["World"], 1, 8)
	Global.level_num = json.get_or_add("Level", 1)
	Global.lives = json["Lives"]
	Global.coins = json["Coins"]
	Global.score = json["Score"]
	
	ChallengeModeHandler.red_coins_collected = json["RedCoins"]
	ChallengeModeHandler.top_challenge_scores = json["ChallengeScores"]
	BooRaceHandler.cleared_boo_levels = json["ClearedBooLevels"]
	Global.player_power_states = json["PowerStates"]
	Global.game_beaten = json["GameWin"]
	for i in json["LevelsVisited"].length():
		visited_levels[i] = json["LevelsVisited"][i]
	Global.extra_worlds_win = json.get("ExtraWorldWin", false)
	SpeedrunHandler.marathon_best_any_time = json.get("BestAnyTime", -1)
	SpeedrunHandler.marathon_best_warpless_time = json.get("BestWarplessTime", -1.0)
	Global.high_score = json["HighScore"]
	if json.has("Ranks"):
		DiscoLevel.level_ranks = json.get("Ranks")
	if json.has("BooBestTimes"):
		BooRaceHandler.best_times = json.get("BooBestTimes").duplicate()

func clear_save() -> void:
	for i in [BooRaceHandler.cleared_boo_levels, ChallengeModeHandler.top_challenge_scores, ChallengeModeHandler.red_coins_collected, visited_levels]:
		if i is Array:
			clear_array(i)
		else:
			i = clear_text(i)
	visited_levels[0][0] = "1"
	var save = SAVE_TEMPLATE.duplicate(true)
	apply_save(save)
	DirAccess.remove_absolute("user://saves/" + Global.current_campaign + ".sav")
	write_save(Global.current_campaign)

func clear_array(arr := []) -> void:
	for i in arr.size():
		if arr[i] is Array:
			clear_array(arr[i])
		elif arr[i] is bool:
			arr[i] = false
		else:
			arr[i] = 0

func clear_text(text := "") -> String:
	for i in text.length():
		if text[i].is_valid_int():
			text[i] = "0"
	return text

func get_level_idx(world_num := 1, level_num := 1) -> int:
	return ((world_num - 1) * 4) + (level_num - 1)

func load_achievements() -> void:
	if FileAccess.file_exists("user://achievements.sav") == false:
		write_achievements()
	var file = FileAccess.open("user://achievements.sav", FileAccess.READ)
	var idx := 0
	for i in file.get_as_text():
		Global.achievements[idx] = i
		idx += 1
	AchievementMenu.unlocked_achievements = Global.achievements
	file.close()

func write_achievements() -> void:
	var file = FileAccess.open("user://achievements.sav", FileAccess.WRITE)
	file.store_string(Global.achievements)
	file.close()
