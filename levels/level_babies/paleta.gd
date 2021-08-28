extends Area2D

onready var anim = $AnimationPlayer

func _process(delta):
	if get_viewport().get_mouse_position().y < 626:
		position = get_viewport().get_mouse_position()
		if Input.is_mouse_button_pressed(1):
			$col.disabled=false
			anim.play("hit")
		else: $col.disabled=true
	if get_viewport().get_mouse_position().y > 630:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else: Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func _ready():
	Input.set_mouse_mode(1)

func _on_paleta_body_entered(body):
	body.get_hit()
