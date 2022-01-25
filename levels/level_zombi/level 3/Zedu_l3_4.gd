extends Area2D

signal player_hurt

func _on_Zedu_l3_4_area_entered(area: Area2D) -> void:
	if area.is_in_group("light"):
		$Timer_hide.start()
	else:
		Utils._get_level().edu_is_dead = true
		queue_free()



func _on_Timer_attack_timeout() -> void:
	emit_signal("player_hurt")
	queue_free()



func _on_Timer_hide_timeout() -> void:
	queue_free()
