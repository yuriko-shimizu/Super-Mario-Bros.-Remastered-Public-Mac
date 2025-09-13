class_name TileGrabber
extends Node

@export var value_name := "item"
@export var saved_node: Node = null
@export var delete_grabbed := false

func tile_grabbed(tile: Node) -> void:
	saved_node = tile
	owner.set(value_name, saved_node)
