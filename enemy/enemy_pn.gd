extends KinematicBody2D

export (int) var speed

onready var timerMove = $moveTimer
onready var timerAttack = $attackTimer
onready var animationPlayer = $AnimationPlayer

var direction = Vector2()
var moving : bool = false

func _ready():
	timerMove.start(2)
	
func _process(delta):
	if moving:
		move_and_slide(speed*direction)

func attack():
	animationPlayer.play("attack")

func choose_direction():
	randomize()
	direction = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
	if position.x > Utils._get_view_size().x - 50 and direction.x > 0:
		direction.x = -direction.x
	if position.y > Utils._get_view_size().y -50 and direction.y > 0:
		direction.y = -direction.y
	if position.x < 50 and direction.x < 0:
		direction.x = -direction.x
	if position.y < 50 and direction.y < 0:
		direction.y = -direction.y

func move():
	moving = true

func _on_moveTimer_timeout():
	timerAttack.start(2)
	choose_direction()
	move()

func _on_attackTimer_timeout():
	moving = false
	attack()
	timerMove.start(2)
