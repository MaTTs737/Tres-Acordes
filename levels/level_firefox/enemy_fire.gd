extends Area2D

signal end

func _on_enemy_fire_body_entered(body):
	emit_signal("end")

