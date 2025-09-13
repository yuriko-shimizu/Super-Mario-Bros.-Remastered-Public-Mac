class_name Track
extends Node2D
const TRACK_PIECE = preload("uid://4gxhnql5bjk6")

@export var path := []
var pieces := []
var length := 0

@export_enum("Closed", "Open") var start_point := 0
@export_enum("Closed", "Open") var end_point := 0
@export var invisible := false:
	set(value):
		invisible = value
		update_pieces()

var editing := false

const DIRECTIONS := [
	Vector2i(-1, -1), # 0
	Vector2i.UP, # 1
	Vector2i(1, -1), # 2
	Vector2i.RIGHT, # 3
	Vector2i(1, 1), # 4
	Vector2i.DOWN, # 5
	Vector2i(-1, 1), # 6
	Vector2i.LEFT # 7
]

func _process(_delta: float) -> void:
	$Point.frame = int(start_point == 0)
	visible = not (invisible and LevelEditor.playing_level)
	if editing and Global.current_game_mode == Global.GameMode.LEVEL_EDITOR:
		if Input.is_action_just_pressed("editor_open_menu") or Input.is_action_just_pressed("ui_cancel"):
			editing = false
			Global.level_editor.current_state = LevelEditor.EditorState.IDLE
			update_pieces()

func _ready() -> void:
	for i in path:
		add_piece(i, false)
	update_pieces()

func update_pieces() -> void:
	var idx := 0
	for i in $Pieces.get_children():
		i.idx = idx
		i.editing = idx >= path.size() and editing
		if idx > 0:
			i.starting_direction = -path[idx - 1]
		else:
			i.starting_direction = Vector2i.ZERO
		if idx <= path.size() - 1:
			i.connecting_direction = path[idx]
		else:
			i.connecting_direction = Vector2i.ZERO
		i.update_direction_textures()
		idx += 1

func add_piece(new_direction := Vector2i.ZERO, add_to_arr := true) -> void:
	var piece = TRACK_PIECE.instantiate()
	var next_position := new_direction * 16
	for i in length:
		next_position += path[i] * 16
	piece.position = next_position
	$Pieces.add_child(piece)
	piece.owner = self
	pieces.append(piece)
	piece.idx = length
	piece.reset_physics_interpolation()
	if add_to_arr:
		path.append(new_direction)
	length += 1
	update_pieces()

func remove_last_piece() -> void:
	$Pieces.get_child($Pieces.get_child_count() - 1).queue_free()
	await get_tree().process_frame
	path.pop_back()
	pieces.pop_back()
	length -= 1
	update_pieces()
