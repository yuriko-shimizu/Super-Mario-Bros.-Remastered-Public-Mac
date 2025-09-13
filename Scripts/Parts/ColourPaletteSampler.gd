class_name ColourPaletteSampler
extends Node

@export var texture: Texture2D = null:
	set(value):
		texture = value
		update()
signal updated

@export var coords := Vector2i.ZERO
@export var node_to_affect: Node = null
@export var value_to_set := ""

func _ready() -> void:
	update()
	Global.level_theme_changed.connect(update)

func update() -> void:
	if node_to_affect == null or texture == null:
		return
	var colour_to_sample: Color = Color.WHITE
	var image = texture.get_image()
	colour_to_sample = image.get_pixelv(coords)
	node_to_affect.set(value_to_set, colour_to_sample)
	updated.emit()
