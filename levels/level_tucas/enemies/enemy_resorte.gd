extends KinematicBody2D

onready var tween = $Tween
onready var pullTimer = $pullTimer
onready var atTimer = $atTimer

var attacking
var pulling

func attack():
	if !attacking:
		tween.interpolate_property(self,"position",position,
		position+Vector2(100,0),0.25,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
		pullTimer.start()
		attacking = true
		pulling = false

func pull():
	if !pulling:
		tween.interpolate_property(self,"position",position,
		position-Vector2(100,0),0.8,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
		atTimer.start()
		pulling = true
		attacking = false
	
func _on_atTimer_timeout():
	attack()

func _on_pullTimer_timeout():
	pull()
