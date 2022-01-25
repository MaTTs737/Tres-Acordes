extends Camera2D

export var camera_speed = 500

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		position.x += camera_speed * delta
	if Input.is_action_pressed("ui_left"):
		position.x -= camera_speed * delta
