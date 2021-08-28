extends "res://enemy/enemy.gd"

func _ready():
	velocity= Vector2(0,rand_range(100,200))
	

func _on_enemy_slow_area_entered(area):
	if area.is_in_group("enemies"):
		velocity = area.velocity # Replace with function body.
