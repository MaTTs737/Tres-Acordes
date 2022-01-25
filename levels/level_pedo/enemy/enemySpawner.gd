extends Node2D

onready var path1 = $enemy_pedo_1
onready var path2 = $enemy_pedo_2
onready var path3 = $enemy_pedo_3

const FOLLOW = preload("res://levels/level_pedo/enemy/enemy_pedo_1_follow.tscn")
const SON = preload("res://levels/level_pedo/enemy/enemy_pedo_little.tscn")

onready var posible_paths = [path1,path2,path3]

export (int) var wave = 0
var total_waves = 30
var wave_count = 0

var specialEnemies

var normal_enemy = 0
var acc_enemy = 0
var invi_enemy = 0
var acor_enemy = 0
var spread_enemy = 0
var enforcedType : String

onready var ENEMY_NORMAL = {
	enemy = preload("res://levels/level_pedo/enemy/enemy_pedo_normal.tscn"),
	start_wave = 1,
	initialMaxLife = 60,
	lifeMulti = 0.1,
	speedMulti = 1,
	spawn_time = 3,
	amount_set = 0,
	timer = $normalTimer
}
onready var ENEMY_ACC = {
	enemy = preload("res://levels/level_pedo/enemy/enemy_pedo_acc.tscn"),
	start_wave = 5,
	initialMaxLife = 25,
	lifeMulti = 0.1,
	speedMulti = 1.3,
	spawn_time = 4,
	amount_set = 0,
	timer = $accTimer
}
onready var ENEMY_INVI = {
	enemy = preload("res://levels/level_pedo/enemy/enemy_pedo_invi.tscn"),
	start_wave = 15,
	initialMaxLife = 60,
	lifeMulti = 0.3,
	speedMulti = 1,
	spawn_time = 6,
	amount_set = 0,
	timer = $inviTimer
}
onready var ENEMY_ACOR = {
	enemy = preload("res://levels/level_pedo/enemy/enemy_pedo_acorazado.tscn"),
	start_wave = 12,
	initialMaxLife = 150,
	lifeMulti = 0.2,
	speedMulti = 0.6,
	spawn_time = 6,
	amount_set = 0,
	timer = $acorTimer
}
onready var ENEMY_SPREAD = {
	enemy = preload("res://levels/level_pedo/enemy/enemy_pedo_spread.tscn"),
	start_wave = 8,
	initialMaxLife = 50,
	lifeMulti = 0.1,
	speedMulti = 0.9,
	spawn_time = 3,
	amount_set = 0,
	timer = $spreadTimer
}

onready var enemies = [ENEMY_NORMAL,ENEMY_ACC,ENEMY_INVI,ENEMY_ACOR,ENEMY_SPREAD]

var BOSS_1 = {
	enemy = preload("res://levels/level_pedo/enemy/boss_1.tscn"),
	speedMulti = 0.15,
	initialMaxLife = 2500,
	lifeMulti = 0
}

var BOSS_2 = {
	enemy = preload("res://levels/level_pedo/enemy/boss_2.tscn"),
	speedMulti = 0.3,
	initialMaxLife = 10000,
	lifeMulti = 0
}

var BOSS_3 = {
	enemy = preload("res://levels/level_pedo/enemy/boss_3.tscn"),
	speedMulti = 0.15,
	initialMaxLife = 20000,
	lifeMulti = 0
}

func _ready():
	next_wave()

func spawn(tipo):
	if checkEnemyAmount():
		var enemy = tipo.enemy.instance()
		randomize()
		var fol = FOLLOW.instance()
		var path = posible_paths[randi() % 3]
		path.add_child(fol)
		set_enemy(enemy, tipo)
		fol.add_child(enemy)

func next_wave():
	wave += 1
	set_wave()
	if wave > 3:
		randomize()
		var random = randi()%11
		if random > 6:
			match random:
				7:
					reforceEnemy(ENEMY_ACC)
					enforcedType = "acc"
				8:
					reforceEnemy(ENEMY_SPREAD)
					enforcedType = "spread"
				9:
					reforceEnemy(ENEMY_INVI)
					enforcedType = "invi"
				10:
					reforceEnemy(ENEMY_ACOR)
					enforcedType = "acor"

#	start_timers()
	for i in enemies:
		launchWave(i)
	$hijo_de_puta.play()
	
	match wave :
		10:
			spawn(BOSS_1)
			$primer_boss.play()
			$acorTimer.start()
			return
		20:
			spawn(BOSS_2)
			$segundo_boss.play()
			return
		30: 
			spawn(BOSS_3)
			return
			
	$waveTimer.start(30+wave*wave)

func _on_waveTimer_timeout():
	next_wave()
	
#func _on_normalTimer_timeout():
#	if normal_enemy < ENEMY_NORMAL.amount_set:
#		spawn(ENEMY_NORMAL)
#		normal_enemy += 1
##		$normalTimer.start(ENEMY_NORMAL.spawn_time)
#
#func _on_accTimer_timeout():
#	if acc_enemy < ENEMY_ACC.amount_set:
#		spawn(ENEMY_ACC)
#		acc_enemy += 1
##		$accTimer.start(ENEMY_ACC.spawn_time)
#
#func _on_inviTimer_timeout():
#	if invi_enemy < ENEMY_INVI.amount_set:
#		spawn(ENEMY_INVI)
#		invi_enemy += 1
##		$inviTimer.start(ENEMY_INVI.spawn_time)
#
#func _on_acorTimer_timeout():
#	if acor_enemy < ENEMY_ACOR.amount_set:
#		spawn(ENEMY_ACOR)
#		acor_enemy += 1
##		$acorTimer.start(ENEMY_ACOR.spawn_time)
#
#func _on_spreadTimer_timeout():
#	if spread_enemy < ENEMY_SPREAD.amount_set:
#		spawn(ENEMY_SPREAD)
#		spread_enemy += 1
#		$spreadTimer.start(ENEMY_SPREAD.spawn_time)

func spread(offset):
	for i in 3:
		var fol = FOLLOW.instance()
		get_child(i).add_child(fol)
		fol.unit_offset = offset
		call_deferred("spawn_sons",fol)

func spawn_sons(fol):
	var son = SON.instance()
	fol.add_child(son)

func countEnemies() -> int:
	specialEnemies = 0
	for i in enemies:
		if i != ENEMY_NORMAL:
			specialEnemies += i.amount_set
	return int(max(0,specialEnemies))

func set_wave ():
	wave_count = wave*7
	ENEMY_ACC.amount_set = int(max(0,(wave - ENEMY_ACC.start_wave) *3))
	ENEMY_INVI.amount_set = int(max(0,(wave - ENEMY_INVI.start_wave) * 3))
	ENEMY_ACOR.amount_set = int(max(0,(wave - ENEMY_ACOR.start_wave) * 2))
	ENEMY_SPREAD.amount_set = int(max(0,(wave - ENEMY_SPREAD.start_wave) * 3))

	ENEMY_NORMAL.amount_set = wave * 4
	
	normal_enemy = 0
	acc_enemy = 0
	invi_enemy = 0
	acor_enemy = 0
	spread_enemy = 0

func set_enemy(enemy:Object, type:Dictionary):
	enemy.normalSpeed = int(min(150,(50+wave*10))) * type.speedMulti
	var maxLife = type.initialMaxLife + (wave*type.lifeMulti*type.initialMaxLife)
	enemy.maxLife = maxLife
	enemy.set_life(maxLife)
	
func start_timers():
	ENEMY_NORMAL.spawn_time = 0.8
	ENEMY_ACC.spawn_time = int(max(1,(ENEMY_NORMAL.amount_set/(ENEMY_ACC.amount_set+0.1))))
	ENEMY_INVI.spawn_time = int(max(1,ENEMY_NORMAL.amount_set/(ENEMY_INVI.amount_set+0.1)))
	ENEMY_ACOR.spawn_time = int(max(1,ENEMY_NORMAL.amount_set/(ENEMY_ACOR.amount_set+0.1)))
	ENEMY_SPREAD.spawn_time = int(max(1,ENEMY_NORMAL.amount_set/(ENEMY_SPREAD.amount_set+0.1)))

	for i in enemies:
		if i.amount_set > 0 :
			i.timer.start()

func spawn_boss_1_minion(origin):
	var posibleEnemies = [ENEMY_ACC,ENEMY_NORMAL,ENEMY_SPREAD]
	var tipo = posibleEnemies[randi() % 3]
	var enemy = tipo.enemy.instance()
	randomize()
	var fol = FOLLOW.instance()
	var path = posible_paths[randi() % 3]
	path.add_child(fol)
	var up_limit = min(1, origin + 0.15)
	var bot_limit = max(0, origin - 0.15)
	fol.unit_offset = rand_range(bot_limit,up_limit)
	set_enemy(enemy, tipo)
	fol.add_child(enemy)

func checkEnemyAmount() -> bool :
	return (normal_enemy+acc_enemy+invi_enemy+acor_enemy+spread_enemy) < wave_count

func reforceEnemy(enemy:Dictionary):
	enemy.amount_set *= 3
	enemy.spawn_time -= enemy.spawn_time*30/100
	for i in enemies:
		if i != enemy:
			i.amount_set *= 0.7

func launchWave(enemy):
	var spawnTime
	match enemy:
		ENEMY_NORMAL:
			spawnTime = 1
		ENEMY_ACC:
			spawnTime = ENEMY_NORMAL.amount_set / (ENEMY_ACC.amount_set+0.1)
		ENEMY_SPREAD:
			spawnTime = ENEMY_NORMAL.amount_set / (ENEMY_SPREAD.amount_set+0.1)
		ENEMY_ACOR:
			spawnTime = ENEMY_NORMAL.amount_set / (ENEMY_ACOR.amount_set+0.1)
		ENEMY_INVI:
			spawnTime = ENEMY_NORMAL.amount_set / (ENEMY_INVI.amount_set+0.1)
				
	for i in enemy.amount_set:
		spawn(enemy)
		var timer = get_tree().create_timer(spawnTime)
		yield(timer,"timeout")

