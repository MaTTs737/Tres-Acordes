extends "res://enemy/enemy.gd"

func _ready():
	velocity = Vector2(0, rand_range(300,1000))
	



func _on_enemy_fast_area_entered(area):
	if area.is_in_group("enemies"):
		velocity = area.velocity # Replace with function body.
