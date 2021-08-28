extends Area2D

signal picked
	
func _on_pickable_body_entered(body):
	emit_signal("picked")
	queue_free()
