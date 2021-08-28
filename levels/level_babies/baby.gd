extends KinematicBody2D

onready var spr = $spr
onready var anim = $AnimationPlayer

signal hit

export (Vector2) var velocity

var dead = false

func _ready():
	if position.x > (Utils._get_view_size().x)/2:
		spr.flip_h = true
	connect("hit",Utils._get_main_node(),"baby_hit")

func _process(delta):
	if !dead:
		move_and_slide(velocity)
		if spr.flip_h:
			anim.play("move_left")
		elif !spr.flip_h: anim.play("move_right")

func get_hit():
	dead = true
	emit_signal("hit")
	anim.play("hit")
	yield(anim,"animation_finished")


