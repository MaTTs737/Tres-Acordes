extends Node2D


func _ready() -> void:
	for i in get_children():
		if i.is_in_group("booster") == false:
			i.add_to_group("obstacle")
