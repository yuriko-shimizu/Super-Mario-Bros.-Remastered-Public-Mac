extends Node

func _process(delta: float) -> void:
	#%ColorRect.visible = bool(Global.colour_palette)
	%ColorRect.material.set_shader_parameter("y_offset", Global.colour_palette)
