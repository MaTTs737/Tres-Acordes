extends KinematicBody2D

onready var effectTimer = $effectTimer
onready var lifeRect = $lifeGreen

export (int) var drops

var maxLife = 20
var life setget set_life
var isFrozen = false
var speed = 30
var normalSpeed = 30
var frozenSpeed = 15
var alive = true

var currentAnim = "walk"
var state = IDLE

var IDLE = {
	speed = 30,
	anim = "walk"
}

var RAGE = {
	speed = 0,
	anim = "rage"
}

func _process(_delta):
	$AnimationPlayer.play(currentAnim)

func _ready():
	set_state(IDLE)
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

func set_state(newState):
	state = newState
	currentAnim = state.anim
	speed = state.speed

func rage():
	$bufftimer.start(4)
	set_state(RAGE)
	print ("funciona")

func heal():
	for area in $healArea.get_overlapping_areas():
		area.heal()

func _on_buffTimer_timeout():
	set_state(IDLE)

func _on_stateTimer_timeout():
	match state:
		IDLE:
			set_state(RAGE)
		RAGE:
			set_state(IDLE)
