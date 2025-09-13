extends Control

signal finished

func show_popup(achievements: Array) -> void:
	var idx := 0
	$Control/Panel/MarginContainer/VBoxContainer/Label.text = "NEW ACHIEVEMENT!" if achievements.size() == 1 else "NEW ACHIEVEMENTS!"
	for i in [%Icon, %Icon2, %Icon3, %Icon4]:
		i.hide()
		i.visible = achievements.size() > idx
		if idx == 3 and achievements.size() > 4:
			i.hide()
			%Extra.show()
			%Extra.text = "+" + str(achievements.size() - 3)
		if i.visible:
			i.region_rect = Rect2(AchievementContainer.ICON_RECTS[achievements[idx]] * 32, Vector2(32, 32))
		idx += 1
	%AchievementName.visible = achievements.size() == 1
	%AchievementName.text = AchievementContainer.ACHIEVEMENT_NAMES[achievements[0]]
	if %AchievementName.text.length() > 16:
		$AnimationPlayer.play("AppearLong")
	else:
		$AnimationPlayer.play("Appear")
	await $AnimationPlayer.animation_finished
	finished.emit()
