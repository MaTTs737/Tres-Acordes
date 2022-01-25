extends Area2D



func _on_cocaine_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.acelerar()
	else:
		return
