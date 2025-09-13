class_name SelectableInputOption
extends HBoxContainer

@export var settings_category := "video"
@export var selected := false

@export var action_name := ""
@export var title := ""

@export_enum("Keyboard", "Controller") var type := 0
@export var player_idx := 0

signal input_changed(action_name: String, input_event: InputEvent)

var awaiting_input := false

static var rebinding_input := false

var event_name := ""

var can_remap := true

var current_device_brand := 0

var input_event: InputEvent = null

const button_id_translation := [
	["A", "B", "✕"],
	["B", "A", "○"],
	["X", "Y", "□"],
	["Y", "X", "△"],
	["Select", "-", "Share"],
	"Home",
	["Start", "+", "Options"],
	["LS Push", "LS Push", "L3"],
	["RS Push", "RS Push", "R3"],
	["LB", "L", "L1"],
	["RB", "R", "R1"],
	"DPad U",
	"DPad D",
	"DPad L",
	"DPad R" 
]

func _process(_delta: float) -> void:
	if selected:
		handle_inputs()
	$Cursor.modulate.a = int(selected)
	$Title.text = tr(title) + ":"
	$Value.text = get_event_string(input_event) if not awaiting_input else "Press Any..."

func handle_inputs() -> void:
	if selected and can_remap:
		if Input.is_action_just_pressed("ui_accept"):
			begin_remap()

func begin_remap() -> void:
	$Timer.stop()
	$Timer.start()
	rebinding_input = true
	can_remap = false
	get_parent().can_input = false
	await get_tree().create_timer(0.1).timeout
	awaiting_input = true

func _input(event: InputEvent) -> void:
	if awaiting_input == false: return
	
	if event.is_pressed() == false:
		return
	
	if event is InputEventKey:
		if event.as_text_physical_keycode() == "Escape":
			cancel_remap()
			return
	
	if type == 0 and event is InputEventKey:
		map_event_to_action(event)
	elif type == 1 and (event is InputEventJoypadButton or event is InputEventJoypadMotion):
		if event is InputEventJoypadMotion:
			event.axis_value = sign(event.axis_value)
		map_event_to_action(event)

func map_event_to_action(event) -> void:
	var action = action_name + "_" + str(player_idx)
	var events = InputMap.action_get_events(action).duplicate()
	events[type] = event
	InputMap.action_erase_events(action)
	for i in events:
		InputMap.action_add_event(action, i)
	input_changed.emit(action, event)
	input_event = event
	awaiting_input = false
	await get_tree().create_timer(0.1).timeout
	rebinding_input = false
	get_parent().can_input = true
	can_remap = true

func get_event_string(event: InputEvent) -> String:
	var event_string := ""
	if event is InputEventKey:
		event_string = OS.get_keycode_string(event.keycode)
	elif event is InputEventJoypadButton:
		var translation = button_id_translation[event.button_index]
		if translation is Array:
			translation = translation[current_device_brand]
		event_string = translation
	elif event is InputEventJoypadMotion:
		var stick = "LS"
		var direction = "Left"
		if event.axis == JOY_AXIS_TRIGGER_LEFT:
			return ["LT", "ZL", "L2"][current_device_brand]
		elif event.axis == JOY_AXIS_TRIGGER_RIGHT:
			return ["RT", "ZR", "R2"][current_device_brand]
		
		if event.axis == JOY_AXIS_RIGHT_X or event.axis == JOY_AXIS_RIGHT_Y:
			stick = "RS"
		if (event.axis == JOY_AXIS_LEFT_X or event.axis == JOY_AXIS_RIGHT_X):
			if event.axis_value < 0:
				direction = "Left"
			else:
				direction = "Right"
		elif (event.axis == JOY_AXIS_LEFT_Y or event.axis == JOY_AXIS_RIGHT_Y):
			if event.axis_value < 0:
				direction = "Up"
			else:
				direction = "Down"
		event_string = stick + " " + direction
	return event_string

func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventJoypadButton and event is not InputEventJoypadMotion:
		return
	var device_name = Input.get_joy_name(event.device)
	if device_name.to_upper().contains("NINTENDO") or device_name.to_upper().contains("SWITCH") or device_name.to_upper().contains("WII"):
		current_device_brand = 1
	elif device_name.to_upper().contains("PS") or device_name.to_upper().contains("PLAYSTATION"):
		current_device_brand = 2
	else:
		current_device_brand = 0

func cancel_remap() -> void:
	awaiting_input = false
	await get_tree().create_timer(0.1).timeout
	rebinding_input = false
	get_parent().can_input = true
	can_remap = true
