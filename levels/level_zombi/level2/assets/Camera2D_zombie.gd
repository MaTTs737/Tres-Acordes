extends Camera2D
onready var tween = $Tween
const camera_pos_hidden = 780
const camera_pos_up = 0

func start_tween_up()-> void:
	tween.interpolate_property(self,"position:y",camera_pos_hidden,camera_pos_up,0.1,tween.TRANS_LINEAR,tween.EASE_IN)
	tween.start()


func start_tween_down()-> void:
	tween.interpolate_property(self,"position:y",camera_pos_up,camera_pos_hidden,0.1,tween.TRANS_LINEAR,tween.EASE_IN)
	tween.start()
