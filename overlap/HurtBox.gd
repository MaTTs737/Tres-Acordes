extends Area2D

const HitEffect = preload("res://effects/hitEffect.tscn")

func create_hitEffect():
	var hitEffect = HitEffect.instance()
	var main = get_parent()
	main.add_child(hitEffect)
	hitEffect.global_position = global_position

func _on_HurtBox_area_entered(_area):
	create_hitEffect()
