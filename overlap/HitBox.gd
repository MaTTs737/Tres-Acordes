extends Area2D

var knockback_vector = Vector2.ZERO

export (int) var damage

func _process(delta):
	knockback_vector = $here.knockback_vector
