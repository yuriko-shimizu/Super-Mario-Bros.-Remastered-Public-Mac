class_name FontUpdater
extends Node

@onready var resource_getter_smb1 := ResourceGetter.new()
@onready var resource_getter_smbll := ResourceGetter.new()
@onready var resource_getter_score := ResourceGetter.new()

@onready var FONT_LL_MAIN = load("uid://djxdgxy1iv8yv")
@onready var FONT_MAIN = load("uid://bl7sbw4nx3l1t")
@onready var SCORE_FONT = load("uid://cflgloiossd8a")


static var current_font: Font = null

func _ready() -> void:
	update_fonts()
	Global.level_theme_changed.connect(update_fonts)

func update_fonts() -> void:
	FONT_MAIN.base_font = resource_getter_smb1.get_resource(FONT_MAIN.base_font)
	FONT_LL_MAIN.base_font = resource_getter_smbll.get_resource(FONT_LL_MAIN.base_font)
	SCORE_FONT.base_font = resource_getter_score.get_resource(SCORE_FONT.base_font)
