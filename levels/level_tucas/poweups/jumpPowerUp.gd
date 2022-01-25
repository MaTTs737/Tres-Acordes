extends "res://pickables/pickable.gd"

func _ready():
	connect("body_entered",self,"_on_pickable_body_entered")




func _on_jumpPowerUp_body_entered(body):
	if body.is_in_group("players"):
		body.max_jump += 1
