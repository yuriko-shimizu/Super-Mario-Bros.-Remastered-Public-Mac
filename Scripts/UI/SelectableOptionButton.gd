extends HBoxContainer

@export var title := ""
@export var selected := false

signal button_pressed

var selected_index := 0

@export var press_sfx := "beep"

func _process(_delta: float) -> void:
	if selected:
		handle_inputs()
	$Cursor.modulate.a = int(selected)
	$Title.text = tr(title)

func handle_inputs() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		button_pressed.emit()
		if press_sfx != "":
			AudioManager.play_global_sfx(press_sfx)
