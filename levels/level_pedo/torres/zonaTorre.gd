extends Area2D

func _ready():
	connect("area_entered",Utils._get_main_node(),"setPutZone")
	connect("area_exited",Utils._get_main_node(),"unsetPutZone")

func placeTower(tower: Object):
	tower.position = Vector2.ZERO
	add_child(tower)
