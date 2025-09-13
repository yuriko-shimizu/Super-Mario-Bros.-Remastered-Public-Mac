class_name LabelFontChanger
extends Node

@export var labels: Array[Label]

const SMB1 = preload("uid://bl7sbw4nx3l1t")
const SMBLL = preload("uid://djxdgxy1iv8yv")
const SCORE_FONT = preload("uid://bk0no5p6sifgu")

@export var use_score_font := false

static var current_font: Font = null

func _ready() -> void:
	refresh_font()
	Global.level_theme_changed.connect(refresh_font)

func refresh_font() -> void:
	if Global.current_campaign == "SMBLL":
		current_font = SMBLL
	else:
		current_font = SMB1
	update_labels()

func update_labels() -> void:
	var font_to_use = current_font
	if use_score_font:
		font_to_use = SCORE_FONT
	for i in labels:
		if i == null:
			continue
		i.remove_theme_font_override("font")
		i.add_theme_font_override("font", font_to_use)
