extends Label

func _process(delta: float) -> void:
	text = str(Utils._get_main_node().player_life)
