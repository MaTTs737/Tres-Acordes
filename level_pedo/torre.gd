extends Area2D

var shooting_dir = Vector2()

const DISPARO = preload("res://levels/level_pedo/ataque_torre_tele.tscn")

func check_y_shoot():
	pass
	
func shoot():
	var disparo = DISPARO.instance()
	disparo.shooting_direction = shooting_dir
	disparo.position = position
	Utils._get_main_node().add_child(disparo)
	


func _on_torre_body_entered(body):
	shooting_dir = (body.position-position).normalized()
	shoot()
