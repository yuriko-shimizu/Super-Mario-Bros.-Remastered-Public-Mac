extends Node

var style := "Overworld"

var level_seed := "8923589235890"

var level_length := 10

const PIECE_FOLDER := "res://Scenes/LevelPieces/"

const OVERWORLD_STYLES := ["Overworld", "Desert", "Snow", "Jungle", "Garden", "Beach", "Mountain", "Autumn"]

@onready var pieces: Node2D = $"../Pieces"

func _enter_tree() -> void:
	owner.theme = OVERWORLD_STYLES.pick_random()
	Global.level_theme = owner.theme
	print(owner.theme)

func _ready() -> void:
	seed(int(level_seed))
	await owner.ready
	build_level()

func build_level() -> void:
	var piece_spawn_point := -96
	var last_piece = self
	for i in level_length:
		var piece = get_next_piece()
		piece.position.x = piece_spawn_point
		piece_spawn_point += piece.length
		$"../Pieces".add_child(piece)
		last_piece = piece

func get_next_piece() -> LevelPiece:
	var piece_num := 0
	var amount_of_pieces := DirAccess.get_files_at(PIECE_FOLDER + style + "/").size()
	piece_num = randi_range(1, amount_of_pieces)
	var path = PIECE_FOLDER + style + "/" + str(piece_num) + ".tscn"
	var next_piece = load(path).instantiate()
	return next_piece
