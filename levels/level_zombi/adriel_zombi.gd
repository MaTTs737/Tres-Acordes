extends Area2D

onready var tween = $Tween


func aparecer(pos):
	$CollisionShape2D.disabled = true
	position = pos
	$Sprite.show()
	tween.interpolate_property(self,"position:x",position.x,position.x-100,0.6,Tween.TRANS_LINEAR,tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_all_completed")
	$CollisionShape2D.disabled = false
	

func ocultar():
	$Sprite.hide()
