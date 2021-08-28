extends Node2D

onready var adriel_pos = $adriel_pos
onready var adriel_zombi = $adriel_zombi

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
	adriel_zombi.aparecer(Vector2(Utils.choise_list(pos_x),Utils.choise_list(pos_y)))
	$spawnTimer.start(1.8)

func _on_offTimer_timeout():
	adriel_zombi.hide()
