class_name StateMachine
extends Node

@export var state: State = null

func transition_to(state_name := "", state_msg := {}) -> void:
	state.exit()
	state.state_exited.emit()
	state = get_node(state_name)
	state.enter(state_msg)
	state.state_entered.emit()

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func _process(delta: float) -> void:
	state.update(delta)
