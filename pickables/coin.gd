extends "res://pickables/pickable.gd"

func _ready():
	connect("picked",Utils._get_main_node(),"add_coin")
