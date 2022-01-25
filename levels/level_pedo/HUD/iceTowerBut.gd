extends TextureButton


func _process(_delta):
	disabled = Utils._get_main_node().coins < Utils._get_main_node().TORRE_ICE.cost
