extends Node2D

const ball = preload("res://levels/level_tucas/level_mago/enemyBall.tscn")
const start_pos =Vector2.ZERO

onready var timer = $Timer

func _ready():
	pass

func _process(delta):
	if timer.time_left == 0:
		timer.start()

func shoot():
	randomize()
	var shootDir = Vector2(rand_range(-1,1),1)
	var newBall = ball.instance()
	newBall.get_dir(shootDir)
	newBall.start(get_parent().position)
	newBall.set_scale(Vector2(0.7,0.7))
	newBall.linear_velocity.x = rand_range(-100,100)
	Utils._get_main_node().add_child(newBall)
	timer.start()

func _on_Timer_timeout():
	shoot()
