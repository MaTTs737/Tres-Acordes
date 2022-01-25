extends KinematicBody2D

var velocity = Vector2()
export (int) var speed

onready var rays = {
	down_ray = $down_ray,
	up_ray = $up_ray,
	right_ray = $right_ray,
	left_ray = $left_ray
}

func _process(delta):
	
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	
	velocity = Vector2.ZERO
	
	if up:
		velocity = Vector2.UP*speed
	if down:
		velocity = Vector2.DOWN*speed
	if left:
		velocity = Vector2.LEFT*speed
	if right:
		velocity = Vector2.RIGHT*speed
		
	move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		attack(delta)

func attack(delta):
	for ray in rays:
		if rays[ray].is_colliding() and rays[ray].get_collider().is_in_group("enemies"):
			rays[ray].get_collider().get_hurt()
#		rays[ray].enabled = true
	print ("attack")
