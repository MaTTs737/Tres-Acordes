extends Area2D

var initial_pos 
var shooting_direction
var goal : Object

export (int) var speed
export (String) var attack_type

var damage
var has_hit = false
var alive = true
var sprite

onready var NORMAL = {
		type = "normal",
		skin = $baston
}

onready var HARD = {
	type = "hard",
	skin = $pistola
}

onready var ICE = {
	type = "ice",
	skin = $hielo
}

onready var skins = [NORMAL,HARD,ICE]

func go(dir : Vector2):
	position += dir

func _ready():
	initial_pos = position
	goal.connect("tree_exited",self,"seguir_de_largo")
	shooting_direction = (goal.global_position - global_position).normalized()
	for i in skins:
		if i.type == attack_type:
			i.skin.visible = true
			sprite = i.skin


func _process(delta):
	if alive:
		shooting_direction = (goal.global_position - global_position).normalized()
		if shooting_direction.x < 0:
			sprite.flip_h = false
		elif shooting_direction.x > 0 :
			sprite.flip_h = true
	go(shooting_direction*speed*delta)
	if position.x > initial_pos.x + 200 or position.x < initial_pos.x - 200:
		queue_free()
	if position.y > initial_pos.y + 200 or position.y < initial_pos.y - 200:
		queue_free()

func _on_ataque_torre_recto_area_entered(_area: Area2D) -> void:
	if !has_hit:
		has_hit = true
		queue_free()

func seguir_de_largo():
	alive = !alive

