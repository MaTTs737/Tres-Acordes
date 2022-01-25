extends Node


signal change_level (level_name)

export (String) var level_name = "level"

onready var positions = $Positions

onready var arreglo = [ ]

const PLAYER = preload("res://levels/level_firefox/player/player_zorro.tscn")
const altura = 4.53

var obstacle_list = [
	preload ("res://levels/level_firefox/obstacles/obstaculos_1.tscn"),
	preload ("res://levels/level_firefox/obstacles/obstaculos_2.tscn"),
	preload ("res://levels/level_firefox/obstacles/obstaculos_3.tscn"),
	preload ("res://levels/level_firefox/obstacles/obstaculos_4.tscn"),
	preload ("res://levels/level_firefox/obstacles/obstaculos_5.tscn"),
]


func _ready() -> void:
	recopilar()
	randomize()
	
	for i in arreglo.size():
		var rand = randi()%5
		var segment = obstacle_list[rand].instance()
		segment.position.x = arreglo[i]
		segment.position.y = altura
		add_child(segment)

func random_for_pos(last_pos) -> int:
	randomize()
	var noesta = false
	var randp = randi()%4
	while noesta == false :
		if !last_pos.has(randp):
			noesta = true
		else: 
			randp = randi()%4
	return randp

func recopilar () -> void:
	for i in positions.get_children():
		arreglo.append(i.position.x)
	


func _on_enemy_fire_end() -> void:
	emit_signal("change_level",level_name)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("obstacle"):
		$winLoseHandler.lose()
