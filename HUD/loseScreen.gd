extends CanvasLayer

onready var menuBut = $Control/menuBut
onready var jugarBut = $Control/jugarBut

signal restart

func _on_jugarBut_pressed():
	emit_signal("restart")
	get_tree().paused = false
	queue_free()


func _on_menuBut_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://HUD/menu.tscn")
