extends KinematicBody2D

export (int) var MAX_SPEED
export (int) var ACCELERATION
export (int) var FRICTION
export (int) var maxLife

onready var animationPlayer = $AnimationPlayer
onready var here = $HitBox/here
onready var sprite = $Sprite

signal life_changed(value)

var velocity = Vector2.ZERO
var facing : String
var life : int

func _ready():
	life = maxLife
	emit_signal ("life_changed",life)
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		if velocity.x < 0:
			facing = "left"
		else: facing = "right"
		#animationPlayer.play("move_"+facing)
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		if velocity.x < 0:
			facing = "left"
		else: facing = "right"
		
	move()
	
	if Input.is_action_just_pressed("attack"):
		if velocity.x < 0 :
			facing = "left"
		else: facing = "right"
		animationPlayer.play("hit")
	
func move():
	velocity = move_and_slide(velocity)

func get_hit():
	life -= 1
	if life <= 0:
		die()

func die():
	queue_free()
