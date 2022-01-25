extends KinematicBody2D

onready var effectTimer = $effectTimer
onready var lifeRect = $lifeGreen

export (int) var drops

const KAME = preload("res://levels/level_pedo/enemy/kameha.tscn")

var maxLife = 20
var life setget set_life
var isFrozen = false
var speed
var normalSpeed
var frozenSpeed = 15
var state
var currentAnim

var IDLE = {
	speed = 30,
	anim = "walk",
	effectVisibility = false
}

var RAGE = {
	speed = 60,
	anim = "rage",
	effectVisibility = true
}

func _ready():
	set_state(IDLE)
	frozenSpeed = 50
	set_life(maxLife)
	$rageTimer.start()
	
func set_life(value):
	life=value
	var unit = $lifeRed.rect_size.x / maxLife
	$lifeGreen.rect_size.x = unit *life

func die ():
	Utils._get_main_node().coins += drops
	get_parent().queue_free()

func get_hurt (damage: int) -> void:
	life -= damage
	if life <= 0:
		die()

func freeze():
	effectTimer.start()
	speed = frozenSpeed
	isFrozen = true

func _on_effectTimer_timeout():
	if isFrozen:
		speed = normalSpeed
		isFrozen=false

func _on_HurtBox_area_entered(area):
	if area.is_in_group("proyectiles"):
		get_hurt(area.damage)
		if area.attack_type == "ice":
			freeze()

func rage():
	set_state(RAGE)
	$kameTimer.start(1)
	$idleTimer.start()
	for area in $buffer.get_overlapping_areas():
		area.buff3()

func set_state(newState):
	state = newState
	currentAnim = state.anim
	speed = state.speed
	$cabellera_saiyayin_2.visible = state.effectVisibility
	$aura_saiya.visible = state.effectVisibility

func shoot_kame():
	var kameha = KAME.instance()
	kameha.position = global_position
	Utils._get_main_node().add_child(kameha)

func _on_rageTimer_timeout():
	rage()

func _on_idleTimer_timeout():
	set_state(IDLE)
	$rageTimer.start(2)

func _on_kameTimer_timeout():
	shoot_kame()
