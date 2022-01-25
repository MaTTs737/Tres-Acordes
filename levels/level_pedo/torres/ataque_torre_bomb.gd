extends Area2D

onready var sprite = $Sprite
export (int) var speed
export (int) var damage 

const EFECTO = preload("res://levels/level_pedo/torres/explosion_bomb.tscn")

var initial_pos 
var shooting_direction
var attack_type : String
var goal
var attackRange = 150

func go(dir : Vector2):
	position += dir
	
func _ready():
	initial_pos = position
	shooting_direction = (goal.global_position - global_position).normalized()

func _process(delta):
	go(shooting_direction*speed*delta)
	if shooting_direction.x < 0:
		sprite.flip_h = false
	elif shooting_direction.x > 0 :
		sprite.flip_h = true
	if position.distance_to(initial_pos) > attackRange:
		hit()

func hit():
	for enemy in get_overlapping_bodies():
		if enemy.is_in_group("enemies"):
			enemy.get_hurt(damage)
	var explosion = EFECTO.instance()
	explosion.global_position = global_position
	Utils._get_main_node().add_child(explosion)
	queue_free()
