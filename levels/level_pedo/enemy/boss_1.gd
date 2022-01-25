extends KinematicBody2D

onready var effectTimer = $effectTimer

export (int) var drops

var maxLife = 2
var life setget set_life
var isFrozen = false
var speed 
var normalSpeed 
var frozenSpeed = 15
var currentAnim = "walk"
var angry = false

var IDLE = {
	speed = 30,
	anim = "walk",
	angry = false
}

var RAGE = {
	speed = 100,
	anim = "attack",
	angry = true
}

var SONS = {
	normal = preload("res://levels/level_pedo/enemy/enemy_pedo_normal.tscn"),
	acc = preload("res://levels/level_pedo/enemy/enemy_pedo_acc.tscn")
}

func _process(_delta):
	$AnimationPlayer.play(currentAnim)
	if life <= maxLife/2 :
		rage()

func _ready():
	set_state(IDLE)
	frozenSpeed = normalSpeed/1.3
	set_life(maxLife)
	
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
		set_state(IDLE)
		isFrozen=false

func _on_HurtBox_area_entered(area):
	if area.is_in_group("proyectiles"):
		get_hurt(area.damage)
		if area.attack_type == "ice":
			freeze()

func set_state(state):
	currentAnim = state.anim
	speed = state.speed
	angry = state.angry

func rage():
	if get_parent().unit_offset < 0.8:
		set_state(RAGE)

func spawnSon():
	var origin = get_parent().unit_offset
	Utils._get_main_node().get_node("enemySpawner").spawn_boss_1_minion(origin)
	


func _on_rageTimer_timeout():
	match angry:
		false:
			rage()
			$rageTimer.start(3)
		true:
			set_state(IDLE)
			$rageTimer.start(5)
