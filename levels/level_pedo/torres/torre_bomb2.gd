extends "res://levels/level_pedo/torres/torre.gd"


func _ready():
	DISPARO = preload("res://levels/level_pedo/torres/ataque_torre_bomb.tscn")
	damage = 10

func _process(_delta):
	shift = Input.is_action_pressed("shift")
	
	if !targets.empty() and !isShooting:
		goal = targets[0]
		shoot()
		isShooting = true
		detector_col.disabled=true
		timer.start()
		
func _upgrade():
	get_tree().call_group("selectedTowers","clean")
	

