extends KinematicBody2D

export (int) var MAX_SPEED
export (int) var ACCELERATION
export (int) var FRICTION

onready var animationPlayer = $AnimationPlayer
onready var here = $HitBox/here
onready var sprite = $Sprite

var velocity = Vector2.ZERO
var knockback_vector = Vector2.ZERO
var facing : String

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		here.knockback_vector = input_vector
		if velocity.x < 0:
			facing = "left"
		else: facing = "right"
		animationPlayer.play("move_"+facing)
		
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		if velocity.x < 0:
			facing = "left"
		else: facing = "right"
		animationPlayer.play("idle_"+facing)
		
	move()
	
	if Input.is_action_just_pressed("attack"):
		if velocity.x < 0 :
			facing = "left"
		else: facing = "right"
		animationPlayer.play("hit_"+facing)
		
	
func move():
	velocity = move_and_slide(velocity)
