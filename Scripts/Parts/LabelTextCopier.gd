extends Node

@export var labels: Dictionary[Label, Label] = {}

func _process(_delta: float) -> void:
	for i in labels.keys():
		labels[i].text = i.text
