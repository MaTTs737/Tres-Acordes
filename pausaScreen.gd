extends CanvasLayer

func _on_salirBut_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://HUD/menu.tscn")

func _on_volverBut_pressed():
	get_tree().paused = false
	queue_free()
	
func _on_resetBut_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
