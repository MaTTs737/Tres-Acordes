extends KinematicBody2D

export var speed = Vector2 (500,500)


func _physics_process(delta: float) -> void:
	var direction = 1
	rotation_degrees = 10
	if Input.is_action_pressed("ui_up"):
		direction = -1
		rotation_degrees = -10
	move_and_slide(calculate_speed(speed,direction))

func calculate_speed (speed: Vector2, direction: int) -> Vector2:
	speed.y = speed.y * direction
	return speed

