extends Node2D

func _enter_tree() -> void:
	setup_bg_scrolling()

var repeat_times := 1:
	set(value):
		if repeat_times != value:
			repeat_times = value
			update_repeats()

@export var scroll_scale := 0.5

func _process(_delta: float) -> void:
	repeat_times = ceil(get_viewport_rect().size.x / 512) + 1

func update_repeats() -> void:
	for i in get_children():
		if i is Parallax2D:
			i.repeat_times = repeat_times

func setup_bg_scrolling() -> void:
	var scr_scale = scroll_scale
	match Global.parallax_style:
		0:
			scr_scale = 1
		1:
			scr_scale = scroll_scale
		2:
			return
	for i in get_children():
		if i is Parallax2D:
			if i.scroll_scale.x < 1:
				i.scroll_scale.x = scr_scale
