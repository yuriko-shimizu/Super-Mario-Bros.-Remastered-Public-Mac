extends Node

enum Type{LEVEL = 22962, RESOURCE_PACK = 25680}
enum Sort{RECENT, DOWNLOADS, FEATURED}

signal response_recieved(response: Dictionary)
signal response_failed()

@onready var http = HTTPRequest.new()

const GAME_ID = 7692

func _ready() -> void:
	add_child(http)
