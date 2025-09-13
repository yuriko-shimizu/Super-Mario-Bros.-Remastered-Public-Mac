class_name AchievementContainer
extends HBoxContainer

var achievement_id := 0

var selected := false

var unlocked := false

const ICON_RECTS := [
	Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0),
	Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1),
	Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), 
	Vector2i(0, 3), Vector2i(1, 3), Vector2i(2, 3), 
	Vector2i(0, 4), Vector2i(1, 4), Vector2i(2, 4), 
	Vector2i(0, 5), Vector2i(1, 5), Vector2i(2, 5), 
	Vector2i(0, 6), Vector2i(1, 6), Vector2i(2, 6), 
	Vector2i(0, 7), Vector2i(1, 7), Vector2i(2, 7), 
	Vector2i(3, 1), Vector2i(3, 2), Vector2i(3, 4)
]

const ACHIEVEMENT_NAMES := [
	"TITLE_SMB1_CLEAR", "TITLE_SMBLL_CLEAR", "TITLE_SMBS_CLEAR", "TITLE_SMBANN_CLEAR",
	"TITLE_SMB1_CHALLENGE", "TITLE_SMBLL_CHALLENGE", "TITLE_SMBS_CHALLENGE",
	"TITLE_SMB1_BOO", "TITLE_SMBLL_BOO", "TITLE_SMBS_BOO",
	"TITLE_SMB1_GOLD_BOO", "TITLE_SMBLL_GOLD_BOO", "TITLE_SMBS_GOLD_BOO",
	"TITLE_SMB1_BRONZE", "TITLE_SMBLL_BRONZE", "TITLE_SMBS_BRONZE",
	"TITLE_SMB1_SILVER", "TITLE_SMBLL_SILVER", "TITLE_SMBS_SILVER",
	"TITLE_SMB1_GOLD", "TITLE_SMBLL_GOLD", "TITLE_SMBS_GOLD",
	"TITLE_SMB1_RUN", "TITLE_SMBLL_RUN", "TITLE_SMBS_RUN",
	"TITLE_ANN_PRANK", "TITLE_SMBLL_WORLD9", "TITLE_COMPLETION"
]

const ACHIEVEMENT_DESCS := [
	"DESC_SMB1_CLEAR", "DESC_SMBLL_CLEAR", "DESC_SMBS_CLEAR", "DESC_SMBANN_CLEAR",
	"DESC_SMB1_CHALLENGE", "DESC_SMBLL_CHALLENGE", "DESC_SMBS_CHALLENGE",
	"DESC_SMB1_BOO", "DESC_SMBLL_BOO", "DESC_SMBS_BOO",
	"DESC_SMB1_GOLD_BOO", "DESC_SMBLL_GOLD_BOO", "DESC_SMBS_GOLD_BOO",
	"DESC_SMB1_BRONZE", "DESC_SMBLL_BRONZE", "DESC_SMBS_BRONZE",
	"DESC_SMB1_SILVER", "DESC_SMBLL_SILVER", "DESC_SMBS_SILVER",
	"DESC_SMB1_GOLD", "DESC_SMBLL_GOLD", "DESC_SMBS_GOLD",
	"DESC_SMB1_RUN", "DESC_SMBLL_RUN", "DESC_SMBS_RUN",
	"DESC_ANN_PRANK", "DESC_SMBLL_WORLD9", "DESC_COMPLETION"
]

var progress := 0
var total_needed := 0

func _ready() -> void:
	setup_visuals()
	set_active(false)

func setup_visuals() -> void:
	var achievement_name = "TITLE_LOCKED_ACHIEVEMENT"
	var rect = Vector2i(3, 3)
	if unlocked:
		achievement_name = ACHIEVEMENT_NAMES[achievement_id]
		rect = ICON_RECTS[achievement_id]
		$PanelContainer.modulate = Color.WHITE
	%Title.text = achievement_name
	%Description.text = ACHIEVEMENT_DESCS[achievement_id]
	%Icon.region_rect = Rect2(rect * 32, Vector2(32, 32))
	%Progress.visible = not unlocked and total_needed > 0
	%ProgressBar.max_value = total_needed
	%ProgressBar.value = progress
	%TotalGot.text = str(progress)
	%TotalNeeded.text = "/" + str(total_needed)

func set_active(active := false) -> void:
	$Cursor.modulate.a = int(active)
	$PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/AutoScrollContainer.is_active = active
	$PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/AutoScrollContainer2.is_active = active
