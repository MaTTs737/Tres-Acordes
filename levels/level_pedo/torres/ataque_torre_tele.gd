extends "res://levels/level_pedo/torres/ataque_torre.gd"

onready var detector=$detector/col

func _process(delta):
	go(shooting_direction)
	detector.disabled = false

func _on_detector_body_entered(body):
	shooting_direction = (body.position - position).normalized()
	detector.disabled = true
