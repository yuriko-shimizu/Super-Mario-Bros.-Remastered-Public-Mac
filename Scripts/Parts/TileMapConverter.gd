@tool
class_name TileMapConverter
extends Node

@export var tilemap: TileMapLayer = null
@export_tool_button("Fix!") var button = update_tilemap

## Current plan is to write a lil script thingy, that can automatically update the tilemaps, cause
## id rather spend 2 hrs making a script to do it all for me, rather than spend 1 hr updating everything manually.

var fixed_cells := []

const MAP := {
	Vector2i(0, 0): 0,
	Vector2i(2, 1): 0,
	Vector2i(2, 0): Vector2i(4, 2),
	Vector2i(0, 7): Vector2i(0, 4),
	Vector2i(1, 0): Vector2i(4, 0),
	
	Vector2i(3, 0): Vector2i(8, 0),
	Vector2i(3, 1): Vector2i(8, 1),
	Vector2i(4, 0): Vector2i(9, 0),
	Vector2i(4, 1): Vector2i(9, 1),
	
	Vector2i(3, 2): Vector2i(8, 2),
	Vector2i(3, 3): Vector2i(8, 3),
	Vector2i(4, 2): Vector2i(9, 2),
	Vector2i(4, 3): Vector2i(9, 3),
	
	Vector2i(3, 4): Vector2i(8, 4),
	Vector2i(3, 5): Vector2i(8, 5),
	Vector2i(4, 4): Vector2i(9, 4),
	Vector2i(4, 5): Vector2i(9, 5),
	
	Vector2i(3, 6): Vector2i(8, 6),
	Vector2i(3, 7): Vector2i(8, 7),
	Vector2i(4, 6): Vector2i(9, 6),
	Vector2i(4, 7): Vector2i(9, 7),
	
	Vector2i(0, 3): Vector2i(5, 0),
	Vector2i(1, 3): Vector2i(6, 0),
	Vector2i(2, 3): Vector2i(7, 0),
	
	Vector2i(0, 2): Vector2i(6, 1),
	Vector2i(0, 9): Vector2i(5, 1),
	Vector2i(1, 9): Vector2i(7, 1),
	Vector2i(2, 9): Vector2i(6, 6),
	
	Vector2i(1, 8): Vector2i(12, 9),
	Vector2i(2, 8): Vector2i(13, 9),
	
	Vector2i(1, 7): Vector2i(12, 8),
	Vector2i(2, 7): Vector2i(13, 8),
	
	Vector2i(5, 8): Vector2i(1, 4),
	Vector2i(6, 8): Vector2i(2, 4),
	Vector2i(7, 8): Vector2i(3, 4),
	
	Vector2i(3, 8): Vector2i(10, 8),
	Vector2i(4, 8): Vector2i(11, 8)
}

func update_tilemap() -> void:
	for cell in tilemap.get_used_cells_by_id(0):
		var changed := false
		if tilemap.get_cell_source_id(cell) != 0 or fixed_cells.has(cell):
			continue
		var atlas_coords = tilemap.get_cell_atlas_coords(cell)
		if MAP.has(atlas_coords):
			changed = true
			if MAP.get(atlas_coords) is int:
				BetterTerrain.set_cell(tilemap, cell, MAP.get(atlas_coords))
			elif MAP.get(atlas_coords) is Vector2i:
				tilemap.set_cell(cell, 0, MAP.get(atlas_coords), tilemap.get_cell_alternative_tile(cell))
		if changed:
			fixed_cells.append(cell)
	print("Done")
