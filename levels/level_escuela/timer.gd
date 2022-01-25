extends Label

onready var timer = Utils._get_main_node().get_node("winTimer")

func _process(delta):
	text = str(int(timer.time_left))
