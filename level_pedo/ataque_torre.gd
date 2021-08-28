extends Area2D

var shooting_direction
export (int) var speed
export (int) var damage = 20

func go(dir : Vector2):
	position += dir

func _process(delta):
	go(shooting_direction*speed*delta)

func _on_ataque_body_entered(body):
	queue_free()
