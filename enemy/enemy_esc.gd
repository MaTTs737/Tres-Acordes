extends KinematicBody2D

export (int) var speed
onready var tween = $Tween
onready var timer = $Timer

var up : bool = false

func _ready():
	timer.start(3)
	
func move_down():
	tween.interpolate_property(self, "position",
		Vector2(position.x,position.y), Vector2(position.x, position.y+400), 5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,0)
	tween.start()
	up = true

func move_up():
	tween.interpolate_property(self, "position",
		Vector2(position.x,position.y), Vector2(position.x, position.y-400), 5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,0)
	tween.start()
	up = false


func _on_Timer_timeout():
	if !up:
		move_down()
		timer.start(8)
		
	elif up:
		move_up()
		timer.start(8)
