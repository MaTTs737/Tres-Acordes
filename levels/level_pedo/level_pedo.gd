extends Node2D

"""

balancear costos / ganancias

"""

onready var references = {
	towerBut = $interfaz/Control/MarginContainer/VBoxContainer/HBoxContainer/normTowerBut,
	iceBut = $interfaz/Control/MarginContainer/VBoxContainer/HBoxContainer/iceTowerBut,
	hardBut = $interfaz/Control/MarginContainer/VBoxContainer/HBoxContainer/hardTowerBut,
	bombBut = $interfaz/Control/MarginContainer/VBoxContainer/HBoxContainer/bombTowerBut,
	deleter = $deleter,
	deleter_col = $deleter/CollisionShape2D,
	deleter_spr = $deleter/delete_spr,
	enemySpawner = $enemySpawner,
	winLose = $winLoseHandler,
	videoPlayer = $Cameracutscene/VideoPlayer,
	lifeLabel= $interfaz/HUD/Control/MarginContainer/HBox1/Hbox2/lifeRect/lifeCountLabel,
	coinCountLabel = $interfaz/HUD/Control/MarginContainer/HBox1/HBoxContainer2/coinCount,
	wave_display = $interfaz/Control2/MarginContainer/HBoxContainer/waveCountLab,
	wave_timer = $enemySpawner/waveTimer,
	wave_time_left = $interfaz/Control2/MarginContainer/HBoxContainer/waveTimeLeft,
	upgradeCost = $interfaz/Control/MarginContainer/VBoxContainer/HBoxContainer2/upgradeCost,
	waveTimer = $interfaz/Control2/MarginContainer/HBoxContainer/waveCountLab/Timer
	}
	
const pausaScreen = preload("res://HUD/pausaScreen.tscn")

export (int) var coins 
export (int) var player_life 

onready var TORRE_NORMAL = {
	cost = 50,
	spr = preload("res://levels/level_pedo/torres/tower_spr.tscn"),
	obj = preload("res://levels/level_pedo/torres/torre_normal.tscn"),
	costLabel = $interfaz/Control/MarginContainer/VBoxContainer/HBoxContainer2/normCost
}

onready var TORRE_HARD = {
	cost = 200,
	spr = preload("res://levels/level_pedo/torres/hard_spr.tscn"),
	obj = preload("res://levels/level_pedo/torres/torre_hard.tscn"),
	costLabel = $interfaz/Control/MarginContainer/VBoxContainer/HBoxContainer2/hardCost
}

onready var TORRE_ICE = {
	cost = 150,
	spr = preload("res://levels/level_pedo/torres/ice_spr.tscn"),
	obj = preload("res://levels/level_pedo/torres/torre_ice.tscn"),
	costLabel = $interfaz/Control/MarginContainer/VBoxContainer/HBoxContainer2/iceCost
}

onready var TORRE_BOMB = {
	cost = 300,
	spr = preload("res://levels/level_pedo/torres/bomb_spr.tscn"),
	obj = preload("res://levels/level_pedo/torres/torre_bomb.tscn"),
	costLabel = $interfaz/Control/MarginContainer/VBoxContainer/HBoxContainer2/bombCost
}

onready var torres = [TORRE_NORMAL,TORRE_HARD,TORRE_ICE,TORRE_BOMB]

var current = {}
var isTowerSel = false
var clicked = false 
var deleting = false
var can_put_tower = false
var score = 0
var shift
var upgradeTotalCost = 0


func _ready():
	setCostsDefault()

func _process(_delta: float) -> void:
	
	references.deleter.position = get_global_mouse_position()
	references.lifeLabel.text = str(player_life)

	shift = Input.is_action_pressed("shift")
	references.coinCountLabel.text = str(coins)
#	coinCount.text = str(coins)
	#crear despliegue de menu indep
	if Input.is_action_just_pressed("pausa"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		var p = pausaScreen.instance()
		add_child(p)
	
#	updateUpgradeCost()

	if player_life <= 0:
		get_node("Cameracutscene").current = true
		references.videoPlayer.play()
		set_process(false)
		yield (get_node("Cameracutscene/VideoPlayer"),"finished")
		get_node("Cameraplay").current = true
		get_node("Cameracutscene/VideoPlayer").queue_free()
		if score < 5000:
			references.winLose.lose()
		else: references.winLose.win()

	if isTowerSel and Input.is_action_just_pressed("attack_mouse") and can_put_tower:
		putTower()
	
	
	if deleting and can_put_tower and Input.is_action_just_pressed("attack_mouse"):
		delete()
		
	if Input.is_action_just_pressed("right_click"):
		if isTowerSel:
			current.spr = null
			current.obj = null
			$Sprite.queue_free()
			isTowerSel = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if deleting:
			deleting = false
			references.deleter_spr.visible =false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		updateUpgradeCost()
	
func putTower():
	if coins >= current.cost:
		var tower = current.obj.instance()
		tower.global_position = get_global_mouse_position()
		add_child(tower)
		coins -= current.cost
		if !shift:
			$Sprite.queue_free()
			isTowerSel = false
			update_cost()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		update_cost()
	# posibilidad de borrar mas de una torre y devolver algo

func delete():
	references.deleter_col.disabled = false
	var erased = 0
	for area in references.deleter.get_overlapping_areas():
		if area.is_in_group("torres") and erased < 1:
			area.queue_free()
			erased += 1
			if !shift:
				deleting = false
				references.deleter_col.disabled = true
				references.deleter_spr.visible = false
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# construir seleccionador de dificultad //
func pick(tower):
	current.spr = tower.spr
	current.obj = tower.obj
	current.cost = tower.cost
	current.costLabel = tower.costLabel
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	isTowerSel = true
	var spr = current.spr.instance()
	add_child(spr)

func putTowerOn():
	can_put_tower = true

func putTowerOff():
	can_put_tower= false

func update_cost():
	for i in torres:
		if i.cost == current.cost:
			match current.cost:
				TORRE_NORMAL.cost:
					i.cost = int(i.cost*1.10)
					i.costLabel.text = "x "+str(i.cost)
				TORRE_ICE.cost:
					i.cost = int(i.cost*1.6)
					i.costLabel.text = "x "+str(i.cost)
				TORRE_HARD.cost:
					i.cost = int(i.cost*1.6)
					i.costLabel.text = "x "+str(i.cost)
				TORRE_BOMB.cost:
					i.cost = int(i.cost*2)
					i.costLabel.text = "x "+str(i.cost)

func disable_tower_buts():
	references.towerBut.disabled = true
	references.iceBut.disabled = true
	references.hardBut.disabled = true
	references.bombBut.disabled = true

func setCostsDefault():
	for i in torres:
		i.costLabel.text = "x "+str(i.cost)

func updateUpgradeCost():
	references.upgradeCost.text = str(upgradeTotalCost)

func _on_normTowerBut_pressed():
	if !isTowerSel and !deleting:
		pick(TORRE_NORMAL)
		disable_tower_buts()

func _on_iceTowerBut_pressed():
	if !isTowerSel and !deleting:
		pick(TORRE_ICE)	
		disable_tower_buts()

func _on_hardTowerBut_pressed():
	if !isTowerSel and !deleting:
		pick(TORRE_HARD)
		disable_tower_buts()

func _on_bombTowerBut_pressed():
	if !isTowerSel and !deleting:
		pick(TORRE_BOMB)
		disable_tower_buts()

func _on_deleteButton_pressed():
	if !deleting and !isTowerSel :
		deleting = true
		references.deleter_spr.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_upgradeButton_pressed():
	references.enemySpawner.next_wave()

func _on_Timer_timeout():
	references.wave_display.text = str(references.enemySpawner.wave)
	references.waveTimer.start(10)

func _on_TimerTL_timeout():
	references.wave_time_left.text=str(int(references.wave_timer.time_left))
