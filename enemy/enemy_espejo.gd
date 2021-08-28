extends Area2D

signal got_hit

onready var animationPlayer = $AnimationPlayer

export (int) var maxLife

var life
var hitting = false


func _ready():
	life = maxLife
	self.connect("got_hit",Utils._get_main_node(),"enemy_hurt")
	
func get_hit():
	if !animationPlayer.is_playing():
		animationPlayer.play("hit")
		life -= 1
		if life <= 0:
			destroy()

func destroy():
	animationPlayer.play("destroy")

func _on_HurtBox_area_entered(area):
	if !animationPlayer.is_playing():
		get_hit()
		emit_signal("got_hit")
