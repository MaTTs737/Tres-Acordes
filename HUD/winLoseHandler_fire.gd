extends "res://HUD/winLoseHandler.gd"

func _on_KinematicBody2D_die():
	lose()

func _on_enemy_fire_die():
	win()

