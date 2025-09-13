extends NoteBlock

const INTRUMENT_SFX := [preload("uid://dia0bsspwrqsn"), preload("uid://d2elbhakm1yfq"), preload("uid://vxox7t6qvyvu"), preload("uid://w44jys81bxjj"), preload("uid://b2lj4akov8ami"), preload("uid://c03nay4r4a2lm"), preload("uid://d0pdbnpfcm80i"), preload("uid://dodww1no4v6qh")]

var pitch := 0.0
var sfx_stream = null

static var can_play := false

@export var play_on_load := false

@export_enum("Bass", "Flute", "Marimba", "Piano", "Rhodes", "Steel", "Trumpet", "Violin") var instrument := 0:
	set(value):
		sfx_stream = INTRUMENT_SFX[value]
		instrument = value
		play_sfx_preview()

@export_enum("A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#") var note := 3:
	set(value):
		note = value
		pitch = get_pitch_scale()
		play_sfx_preview()

@export_range(1, 5) var octave := 2:
	set(value):
		octave = value
		pitch = get_pitch_scale()
		play_sfx_preview()

func _ready() -> void:
	await get_tree().create_timer(0.1, true).timeout
	can_play = true

func _exit_tree() -> void:
	can_play = false

func get_pitch_scale() -> float:
	var semitone_offset = (octave - 2) * 12 + (note - 3)  # C4 is the base note (note index 3)
	return 2.0 ** (semitone_offset / 12.0)

func _process(_delta: float) -> void:
	%Note.frame = note
	%Octave.frame = octave + 12

func play_sfx_preview() -> void:
	if get_node_or_null("Instrument") != null and can_play:
		print($Instrument.pitch_scale)
		$Instrument.stream = sfx_stream
		$Instrument.pitch_scale = pitch
		$Instrument.play()


func on_screen_entered() -> void:
	if play_on_load and LevelEditor.playing_level:
		play_sfx_preview()
