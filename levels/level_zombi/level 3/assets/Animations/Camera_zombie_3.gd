extends Camera2D

onready var tween = $Tween

func start_tween()-> void:
	tween.interpolate_property(self,"position:x",position.x,0,1,tween.TRANS_LINEAR,tween.EASE_IN)
	tween.start()
