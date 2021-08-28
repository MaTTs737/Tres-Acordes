extends RigidBody2D

export (int) var speed = 3
var direction : Vector2
var contactos = 0
var cont_max = 15
#func _process(delta):
#	position += transform * direction * speed * delta

func start(pos):
	position = pos

func get_dir(vector:Vector2):
	direction = vector

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_enemyBall_body_entered(body):
	if body.is_in_group("players"):
		queue_free()
	else: 
		contactos += 1
		if contactos >= cont_max:
			queue_free()
