extends KinematicBody2D

onready var startPos= $startPos.global_position.y
onready var endPos= $endPos.global_position.y

export (int) var speed
export (int) var gravity

var velocity = Vector2()
var facing = 1

const death = preload("res://effects/deathEffect.tscn")

func _physics_process(delta):
	velocity.y = facing * speed
	
	velocity = move_and_slide(velocity)
	
	if position.y <= endPos or position.y>= startPos:
		turn()
		
	if position.y > 1000:
		queue_free()

func die():
	var d = death.instance()
	d.global_position = global_position
	Utils._get_main_node().add_child(d)
	queue_free()
	
func turn():
	facing *= -1
