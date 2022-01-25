extends CanvasLayer

onready var menuBut = $Control/menuBut
onready var jugarBut = $Control/jugarBut

func _on_menuBut_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://HUD/menu.tscn")


func _on_jugarBut_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	queue_free()
	
	
