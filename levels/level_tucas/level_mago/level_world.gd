extends Node2D

onready var enemy= $enemy_world
onready var enemy_pos = $enemy_start_pos.position
onready var HUD = $HUD
onready var player = $player_tile
onready var player_pos = $player_start_pos.position
onready var enemies = $enemies
onready var tucas = $tucas
onready var enemyLifeRect= $enemyStats/Control/lifeRect
onready var score = AbstractPlayer.score
onready var winLose = $winLoseHandler 

var enemyMaxLife = 100
var enemyLife
var coinsPick = 0

const PLAYER = preload("res://levels/level_tucas/player/player_tile.tscn")
const ENEMY = preload("res://levels/level_tucas/level_mago/enemy_workd.tscn")

func _ready():
	enemyLife = enemyMaxLife
	set_life_rect(enemyLife)

func tuca_picked():
	score += 10
	player.tucas+=1
#	HUD.set_tucas(player.tucas)
#	HUD.set_score(score)

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

func add_coin():
	coinsPick += 1
	HUD.set_coins(coinsPick)
	HUD.showHUD()
