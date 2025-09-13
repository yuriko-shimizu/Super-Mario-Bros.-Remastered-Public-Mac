class_name TextShadowColourChanger
extends Node

@export var labels: Array[Label] = []
@export var shadow_node: CanvasItem = null
@export var override_shadow_colour := Color(0, 0, 0, 0)
var text_shadow_colour = Color.BLACK

static var global_text_shadow_color := Color.BLACK:
	set(value):
		global_text_shadow_color = value

func _ready() -> void:
	Global.level_theme_changed.connect(handle_shadow_colours)
	Global.text_shadow_changed.connect(handle_shadow_colours)
	handle_shadow_colours()

func handle_shadow_colours() -> void:
	text_shadow_colour = global_text_shadow_color
	if override_shadow_colour != Color(0, 0, 0, 0):
		text_shadow_colour = override_shadow_colour
	if Settings.file.visuals.text_shadows == 0:
		text_shadow_colour = Color(0, 0, 0, 0)
	for i in labels:
		if is_instance_valid(i):
			i.add_theme_color_override("font_shadow_color", text_shadow_colour)
	if shadow_node != null:
		shadow_node.modulate.a = (text_shadow_colour.a)
		if shadow_node.material != null:
			shadow_node.material.set_shader_parameter("shadow_colour", text_shadow_colour)
