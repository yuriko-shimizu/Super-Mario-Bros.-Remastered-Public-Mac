extends Control

signal cancelled
var is_active := false

func _physics_process(delta: float) -> void:
	modulate.a = lerpf(modulate.a, int(is_active), delta * 15)
	if Input.is_action_just_released("ui_back") and is_active:
		cancelled.emit()
		is_active = false
		$AnimationPlayer.stop()

func start() -> void:
	$AnimationPlayer.play("Animation")
	is_active = true
	await $AnimationPlayer.animation_finished
	get_tree().quit()
