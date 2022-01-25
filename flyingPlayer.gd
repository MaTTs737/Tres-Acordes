extends KinematicBody2D

signal results(life,tucas,pos)

onready var camara = $Camera2D

export (int) var speed

var velocity
var tucas
var lifes

func _ready():
	connect("results",Utils._get_main_node(),"start_player")
	$deathTimer.start()

func _process(delta):
	get_input()
	print ($deathTimer.time_left)

func get_input():
	velocity = Vector2((Input.get_action_strength("ui_right")- Input.get_action_strength("ui_left")),(Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))).normalized()
	velocity = move_and_slide(velocity*speed)

func start(pos,life):
	position = pos
	tucas = 0
	lifes = life

func die():
	emit_signal("results",global_position,lifes,tucas)
	queue_free()
	
func _on_deathTimer_timeout():
	die()
