class_name SecondQuestNode
extends Node

@export var enabled := true
@export var nodes_to_delete: Array[Node] = []

func _ready() -> void:
	if Global.second_quest or enabled:
		for i in nodes_to_delete:
			i.queue_free()
	else:
		queue_free()
