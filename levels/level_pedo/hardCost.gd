extends Label

func _ready():
	text = "x "+str(Utils._get_main_node().TORRE_HARD.cost)
