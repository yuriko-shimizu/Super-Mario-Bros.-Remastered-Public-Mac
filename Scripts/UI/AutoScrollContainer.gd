@tool
class_name AutoScrollContainer
extends ScrollContainer

var is_focused := false

@export_enum("Wave", "Endless") var mode := 0
@export_enum("Horizontal", "Vertical") var direction := 0

var scroll_direction := "scroll_vertical"

var scroll := 0.0

@export var is_active := false
@export var auto_connect_focus := true
@export var auto_minimum_resize := false

func _ready() -> void:
	scroll_direction = "scroll_horizontal" if direction == 0 else "scroll_vertical"
	set_focused(is_active)
	if auto_connect_focus:
		owner.focus_entered.connect(set_focused.bind(true))
		owner.focus_exited.connect(set_focused.bind(false))
	if auto_minimum_resize:
		get_child(0).resized.connect(update_sizing)

func set_focused(enabled := false) -> void:
	is_focused = enabled

func _physics_process(delta: float) -> void:
	wave(delta)

func update_sizing() -> void:
	custom_minimum_size.x = clamp(get_child(0).size.x, 0, 100)

var scroll_pos := 0.0
var scroll_speed := 16.0 # pixels per second
var move_direction := 1

func wave(delta: float) -> void:
	if not is_focused:
		scroll_pos = 0
		set_deferred(scroll_direction, -1)

	var total_range := 0.0
	if direction == 0:
		total_range = get_child(0).size.x - size.x
	else:
		total_range = (get_child(0).size.y) - (size.y + 8)

	if total_range <= 0:
		return
	if scroll_pos > total_range + 16 or scroll_pos <= -16:
		move_direction *= -1

	scroll_pos += scroll_speed * move_direction * delta
	if direction == 0:
		scroll_horizontal = scroll_pos
	else:
		scroll_vertical = scroll_pos

func endless(delta: float) -> void:
	scroll = wrap(scroll - delta, 0, 1)
	var amount = lerpf(0.0, get_child(0).size.x - size.x, scroll)
	scroll_horizontal = amount
