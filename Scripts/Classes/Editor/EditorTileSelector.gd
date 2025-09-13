class_name EditorTileSelector
extends Control

@export var tile_name := ""
@export_enum("Tile", "Entity", "Terrain") var type := 0
@export var icon_texture: Resource = null
@export var icon_region_override := Rect2(0, 0, 0, 0)

@export var secondary_icon_texture: Resource = null
@export var secondary_icon_region_override := Rect2(0, 0, 0, 0)

@export_category("Entity")
@export var entity_scene: PackedScene = null
@export var tile_offset := Vector2i(0, 8)

@export_category("Tile")
@export var source_id := 0
@export var terrain_id := 0
@export var tile_coords := Vector2i.ZERO
@export var flip_h := false
@export var flip_v := false

var texture_rect_region := Rect2(0, 0, 0, 0)

signal tile_selected(selector: EditorTileSelector)


var mouse_hovered := false

var disabled := false

func _ready() -> void:
	set_icon_texture()
	set_second_icon_texture()
	update_visuals()
	set_process(false)
	if tile_selected.is_connected(owner.on_tile_selected) == false:
		tile_selected.connect(owner.on_tile_selected)
	%NameLabel.text = tile_name

func _process(_delta: float) -> void:
	var target_position = get_viewport().get_mouse_position()
	target_position.x = clamp(target_position.x, %Panel.size.x / 2, (get_viewport().get_visible_rect().size.x) - %Panel.size.x / 2)
	%NamePanel.position = target_position

func set_icon_texture():
	if icon_texture == null:
		return
	if icon_texture is JSON:
		$ResourceSetterNew.resource_json = icon_texture
		$ResourceSetterNew.update_resource()
	else:
		%Icon.texture = ResourceSetter.get_resource(icon_texture, %Icon)

func set_second_icon_texture():
	if secondary_icon_texture == null:
		return
	if secondary_icon_texture is JSON:
		$ResourceSetterNew2.resource_json = secondary_icon_texture
		$ResourceSetterNew2.update_resource()
	elif secondary_icon_texture is ThemedResource:
		%SecondaryIcon.texture = ResourceSetter.get_resource(secondary_icon_texture, %SecondaryIcon)
	else:
		%SecondaryIcon.texture = secondary_icon_texture


func on_pressed() -> void:
	tile_selected.emit(self)


func update_visuals() -> void:
	if icon_region_override != Rect2(0, 0, 0, 0):
		%Icon.region_rect = icon_region_override
	if secondary_icon_region_override != Rect2(0, 0, 0, 0):
		%SecondaryIcon.region_rect = secondary_icon_region_override
	modulate = Color.WHITE if not disabled else Color.DIM_GRAY

func set_mouse_hovered(hovered := false) -> void:
	%NamePanel.visible = hovered and tile_name.is_empty() == false
	mouse_hovered = hovered
	$Button.disabled = disabled
	set_process(hovered)

func on_mouse_entered() -> void:
	set_mouse_hovered(true)


func on_mouse_exited() -> void:
	set_mouse_hovered(false)
