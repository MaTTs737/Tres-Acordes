extends Node2D

onready var enemy= $level_prueba/enemy_world
onready var enemy_pos = $level_prueba/enemy_start_pos.position
onready var HUD = $level_prueba/HUD
onready var player = $level_prueba/player_tile
onready var player_pos = $level_prueba/player_start_pos.position
onready var enemies = $level_prueba/enemies
onready var tucas = $level_prueba/tucas
onready var enemyLifeRect= $level_prueba/enemyStats/Control/lifeRect
onready var score = AbstractPlayer.score

#var oldEnemy
#var has_restarted = false
var enemyMaxLife = 100
var enemyLife

var winLose = [
	preload("res://HUD/winScreen.tscn"),
	preload("res://HUD/loseScreen.tscn")
]

const PLAYER = preload("res://levels/level_mago/player_tile.tscn")
const ENEMY = preload("res://enemy/enemy_workd.tscn")

func _ready():
	enemyLife = enemyMaxLife
	set_life_rect(enemyLife)

func tuca_picked():
	score += 10
	player.tucas+=1
	HUD.set_tucas(player.tucas)
	HUD.set_score(score)

func enemy_hurt():
	enemyLife -= 10
	score += 10
	HUD.set_score(score)
	if enemyLife <= 0:
		enemy.die()
	set_life_rect(enemyLife)


func set_life_rect(life):
	enemyLifeRect.rect_size.x = enemyLife * 7

func restart():
	HUD.update_start()
	enemies.update_start()
	tucas.update_start()
	player.update_start(player_pos)
	enemy.update_start(enemy_pos)
	enemyLife = enemyMaxLife
	set_life_rect(enemyLife)
	score = AbstractPlayer.score
	HUD.set_score(score)
	HUD.set_tucas(AbstractPlayer.tucas)

"""
IDEAS

RAYO CADA TANTO
"""

func _on_player_tile_die():
	get_tree().paused = true
	score = AbstractPlayer.score
	var screen = winLose[1].instance()
	screen.connect("restart",Utils._get_main_node(),"restart")
	add_child(screen)

func _on_enemy_world_die():
	AbstractPlayer.score = score
	AbstractPlayer.tucas = tucas
	get_tree().paused = true
	var screen = winLose[0].instance()
	screen.connect("restart",Utils._get_main_node(),"restart")
	add_child(screen)

