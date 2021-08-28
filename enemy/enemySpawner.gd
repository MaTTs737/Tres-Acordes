extends Node

onready var spawnPos1 = $spawnPos1.position
onready var spawnPos2 = $spawnPos2.position
onready var spawnPos3 = $spawnPos3.position

onready var enemies = [
	preload("res://enemy/enemy_fast.tscn"),
	preload("res://enemy/enemy_slow.tscn"),
	preload("res://enemy/enemy_swapy.tscn")
]

onready var spawnPosList = [
	spawnPos1,
	spawnPos2,
	spawnPos3
]

func _ready():
	$spawnTimer.start()

func spawn():
	var enemy = Utils.choise_list(enemies).instance()
	var pos = Utils.choise_list(spawnPosList)
	enemy.position = pos
	add_child(enemy)


func _on_spawnTimer_timeout():
	spawn()
	$spawnTimer.wait_time=rand_range(1,4)
	$spawnTimer.start()
