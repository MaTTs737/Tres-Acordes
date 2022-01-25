extends Path2D

func _on_Position2D_body_entered(body):
	if body.is_in_group("players"):
		$PathFollow2D.run()



func _on_Position2D_area_entered(area):
	if area.is_in_group("players"):
		$PathFollow2D.run()
