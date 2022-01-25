extends Area2D

signal is_hurt


onready var pos_Zjaique1 = $Position_Zjaique1
onready var pos_Zjaique2 = $Position_Zjaique2
onready var pos_Zjaique_down = $Position_Zjaique_down

onready var Zjaique_timer = $Timer_Zjaique
onready var Zjaique_timer_down = $Timer_Zjaique_down

onready var pos_list_Zjaique_x = [pos_Zjaique1.position.x,pos_Zjaique2.position.x]
onready var pos_list_Zjaique1_y = [pos_Zjaique2.position.y,pos_Zjaique2.position.y]


var Zjaique_life = 10
var knife = preload("res://levels/level_zombi/level2/enemies/Attacks/Knife/cuchillo.tscn")
var is_down = false
var is_dead = false


func _on_Timer_timeout() -> void:
	if is_dead:
		return
	randomize()
	if is_down == true:                     ## si jaique recibio un tiro y esta en el suelo no puede atacar
		return
	var rand = randi()%3                    ## Cada segundo jaique tendra un 30% de chances de lanzar un cuchillo
	if rand == 1:
		var attack = knife.instance()
		attack.connect("player_hurt",Utils._get_level(),"is_player_hurt")
		add_child(attack)




func _on_enemy_zombi_3_area_entered(area: Area2D) -> void:
	if is_dead:
		return
	if area.is_in_group("proyectil"):
		Zjaique_life -= 10
		if !is_down:
			emit_signal("is_hurt")
			is_down = true
		position.x = pos_Zjaique_down.position.x
		position.y = pos_Zjaique_down.position.y
		rotation_degrees = 90
		if Zjaique_timer_down.is_stopped():
			Zjaique_timer_down.start()
		if Zjaique_life <= 0:
			is_dead = true
			is_down = false
			die()


func _on_Timer_Zjaique_timeout() -> void:
	if is_down or is_dead:
		return
	randomize()
	var rand = randi()%2
	position.x = pos_list_Zjaique_x [rand]


func _on_Timer_Zjaique_down_timeout() -> void:
	randomize()
	var randout = randi()%2
	position.x = pos_list_Zjaique_x [randout]
	position.y = pos_list_Zjaique1_y [randout]
	rotation_degrees = 0
	is_down = false

func die():
		hide()
#	position.x = pos_Zjaique_down.position.x
#	position.y = pos_Zjaique_down.position.y
#	rotation_degrees = 90
