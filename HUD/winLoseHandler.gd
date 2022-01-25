extends  Node2D

var winLose = [
	preload("res://HUD/winScreen.tscn"),
	preload("res://HUD/loseScreen.tscn")
]

func win():
	get_tree().paused = true
	var screen = winLose[0].instance()
	Utils._get_main_node().add_child(screen)
	
func lose():
	get_tree().paused = true
	var screen = winLose[1].instance()
	Utils._get_main_node().add_child(screen)
