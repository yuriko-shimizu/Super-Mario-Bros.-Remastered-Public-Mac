class_name TilePropertySceneRef
extends TilePropertyContainer

signal open_tile_menu(this)

var scene: PackedScene = null

const replace_scenes := {"res://Scenes/Prefabs/Entities/Items/Coin.tscn": "res://Scenes/Prefabs/Entities/Items/SpinningCoin.tscn"}

func set_starting_value(start_value = null) -> void:
	%SceneName.text = get_scene_path(start_value)

func open_tile_selection_menu() -> void:
	open_tile_menu.emit(self)

func set_scene(selector: EditorTileSelector) -> void:
	scene = selector.entity_scene
	if replace_scenes.has(scene.resource_path):
		scene = load(replace_scenes[scene.resource_path])
	%SceneName.text = get_scene_path(scene)

	value = scene
	value_changed.emit(self, scene)

func get_scene_path(var_scene: PackedScene = null) -> String:
	if var_scene == null:
		return "Empty"
	else:
		return var_scene.resource_path.get_file().replace(".tscn", "").to_snake_case().replace("_", " ")
