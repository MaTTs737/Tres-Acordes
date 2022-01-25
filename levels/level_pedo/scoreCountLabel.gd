extends Label

func _process(delta):
	text = str(Utils._get_main_node().score)
