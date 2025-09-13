class_name State
extends Node

signal state_entered
signal state_exited

@onready var state_machine: StateMachine = get_parent()

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func update(_delta: float) -> void:
	pass
