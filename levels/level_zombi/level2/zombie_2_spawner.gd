extends Node2D

onready var adriel_pos = $adriel_pos
onready var zombi_2 = preload("res://levels/level_zombi/level2/enemies/enemy_zombi_2_path.tscn")

var pos_x = []
var pos_y = []

func _ready():
	recopilar()
	
func recopilar():
	for i in adriel_pos.get_children():
		var x = i.position.x
		var y = i.position.y
		pos_x.append(x)
		pos_y.append(y)

func _on_spawnTimer_timeout():
	randomize()
	var zombi = zombi_2.instance()
	zombi.position.x = Utils.choise_list(pos_x)
	zombi.position.y = Utils.choise_list(pos_y)
	add_child(zombi)
	$spawnTimer.start(1.8)
