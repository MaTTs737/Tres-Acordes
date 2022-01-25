extends Label

func _process(delta: float) -> void:
	text = str(Utils._get_level().player_life)
