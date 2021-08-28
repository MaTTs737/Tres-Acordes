extends Area2D

var objetive = null


func can_see_player():
	return objetive != null

func _on_playerDetection_body_entered(body):
	objetive = body


func _on_playerDetection_body_exited(body):
	objetive = null
