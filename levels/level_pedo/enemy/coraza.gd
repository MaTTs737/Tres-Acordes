extends Area2D

var life = 100

func get_hurt (damage: int) -> void:
	life -= damage
	if life <= 0:
		die()

func die():
	queue_free()
	
func _on_coraza_area_entered(area):
	get_hurt(area.damage)
