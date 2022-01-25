extends KinematicBody2D

onready var startPos= $startPos.global_position.x
onready var endPos= $endPos.global_position.x

export (int) var speed
export (int) var gravity

var velocity = Vector2()
var facing = 1

const death = preload("res://effects/deathEffect.tscn")

func _physics_process(delta):
	$Sprite.flip_h = velocity.x > 0
	velocity.y += gravity * delta
	velocity.x = facing * speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if position.x >= endPos or position.x<= startPos:
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

func hurt():
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("tuca_throw")
