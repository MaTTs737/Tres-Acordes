extends Node2D

signal die

export (int) var maxLife =100
export (int) var damage

onready var animPlayer = $puntero/AnimationPlayer
onready var puntero = $puntero

var dir : String = "right"
var punt_dir = "up"
var moving = true

func update_start(pos):
	position = pos
	self.show()
	moving = true

func die():
	self.hide()
	emit_signal("die")
	
func move(dir):
	match dir:
		"right":
			position.x += 1
		"left":
			position.x -= 1

func punt_move(dir):
	match dir:
		"up":
			puntero.position.y -= 1
		"down":
			puntero.position.y += 1
			
func _process(delta):
	if moving:
		if global_position.x <= 370 :
			dir = "right"
		elif global_position.x >= 630 :
			dir = "left"
		move(dir)
		punt_move(punt_dir)
		
		if puntero.position.y <= 250 :
			punt_dir = "down"
		elif puntero.position.y >= 700 :
			punt_dir = "up"
		punt_move(dir)
	
func _on_puntero_body_entered(body):
	puntero.global_position=body.global_position
	animPlayer.play("chupar")
	body.sucked()
	moving = false
