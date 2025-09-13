class_name ScoreNoteSpawner
extends Node
const ONE_UP_NOTE = preload("res://Scenes/Parts/OneUpNote.tscn")
const SCORE_NOTE = preload("res://Scenes/Parts/ScoreNote.tscn")
@export var note_offset := Vector2(0, -8)
@export var add_score := false
@export var play_sfx := false

func spawn_note(amount = 100, amount_2 := 0) -> void:
	if amount is not int or amount_2 != 0:
		amount = amount_2
	var note = SCORE_NOTE.instantiate()
	note.global_position = owner.global_position + note_offset
	if add_score:
		Global.score += amount
	note.get_node("Container/Label").text = str(amount)
	if play_sfx:
		play_death_sfx()
	Global.current_level.add_child(note)

func play_death_sfx() -> void:
	AudioManager.play_sfx("kick", owner.global_position)

func spawn_one_up_note() -> void:
	var note = ONE_UP_NOTE.instantiate()
	note.global_position = owner.global_position + note_offset
	owner.add_sibling(note)
