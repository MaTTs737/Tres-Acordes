extends Area2D

onready var detector = $Area2D
onready var detector_col = $Area2D/detector
onready var timer = $Timer

var upgradeCost = 100

# código para selección
var selected = false

#func set_selected():
#	if !shift:
#		get_tree().call_group("selectedTowers","unselect")
#	if selected:
#		unselect()
#	else:
#		select()
#
#func unselect():
#	selected = false
#	$aura_boss_1.visible = false
#	if is_in_group("selectedTowers"):
#		remove_from_group("selectedTowers")
#		Utils._get_main_node().upgradeTotalCost -= upgradeCost
#
#func select():
#	selected = true
#	$aura_boss_1.visible = true
#	add_to_group("selectedTowers")
#	Utils._get_main_node().upgradeTotalCost += upgradeCost
#
#func _input_event(viewport, event, shape_idx):
#	if Input.is_action_just_released("attack_mouse"):
#		set_selected()
#
var level = 0
var damage = 10
var isShooting = false
var goal
var upgradeable = false
var shift = false
var bulletSpeed = 300

export (String) var attackType

var targets = [] 

var DISPARO = preload("res://levels/level_pedo/torres/ataque_torre_recto.tscn")

func shoot():
	var disparo = DISPARO.instance()
	disparo.attack_type = attackType
	disparo.goal = goal
	disparo.damage = damage
	disparo.speed = bulletSpeed
#	disparo.position = self.position
	add_child(disparo)


func _on_Timer_timeout():
	isShooting = false
	detector_col.disabled=false

func _upgrade():
	pass

func _on_Area2D_area_entered(area):
	targets.append(area)

func _on_Area2D_area_exited(area):
	targets.erase(area)

func _on_upgradeTimer_timeout():
	upgradeable = true
	
