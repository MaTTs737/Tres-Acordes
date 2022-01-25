extends "res://pickables/pickable.gd"


func _ready():
	connect("picked",Utils._get_main_node(),"life_picked")
	connect("body_entered",self,"_on_pickable_body_entered")
