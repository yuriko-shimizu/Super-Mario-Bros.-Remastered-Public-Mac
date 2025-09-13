extends Node

const MUSIC := {
	"SMB1": SMB1_BGM,
	"SMBLL": SMB1_BGM,
	"SMBS": SMBS_BGM,
	"SMBANN": SMB1_BGM
}

const SMBS_BGM := {
	1: ("res://Assets/Audio/BGM/Overworld.json"),
	2: ("res://Assets/Audio/BGM/Garden.json")
}

const SMB1_BGM := {
	1: ("res://Assets/Audio/BGM/Overworld.json"),
	2: ("res://Assets/Audio/BGM/Desert.json"),
	3: ("res://Assets/Audio/BGM/Snow.json"),
	4: ("res://Assets/Audio/BGM/Jungle.json"),
	5: ("res://Assets/Audio/BGM/Desert.json"),
	6: ("res://Assets/Audio/BGM/Snow.json"),
	7: ("res://Assets/Audio/BGM/Jungle.json"),
	8: ("res://Assets/Audio/BGM/Overworld.json"),
	9: ("res://Assets/Audio/BGM/Space.json"),
	10: ("res://Assets/Audio/BGM/Autumn.json"),
	11: ("res://Assets/Audio/BGM/Pipeland.json")
}

func _enter_tree() -> void:
	Global.current_level.music = load(MUSIC[Global.current_campaign][Global.world_num])
