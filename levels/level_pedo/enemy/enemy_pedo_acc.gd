extends KinematicBody2D

onready var effectTimer = $effectTimer
onready var speedTimer= $speedTimer
onready var lifeRect = $lifeGreen
onready var accTimer = $accTimer

export (int) var drops = 25
var maxLife
var life setget set_life
var isFrozen = false
var accelerating

var speed
var normalSpeed
var frozenSpeed
var state
var shield = false

var accState = {
	normalSpeed = 572,
	frozenSpeed = 200,
}
var normalState = {
	normalSpeed = 200,
	frozenSpeed = 100
}

func selectSprite(sprite : String):
	for i in $sprites.get_children():
		if i.name == sprite:
			i.visible = true
		else: i.visible = false

func _ready():
	set_state(normalState)
	accTimer.start(2)
	speed = normalSpeed
	selectSprite("normal")

func set_life(value):
	life=value
	var unit = $lifeRed.rect_size.x / maxLife
	$lifeGreen.rect_size.x = unit *life

func die ():
	Utils._get_main_node().coins += drops
	get_parent().queue_free()

func get_hurt (damage: int) -> void:
	$"efecto_daño".play()
	life -= damage
	if life <= 0:
		die()

func freeze():
	effectTimer.start()
	if !isFrozen:
		speed = frozenSpeed
		isFrozen = true
		selectSprite("frozen")

func buff3():
	$aura_saiya.visible= true
	speed *= 1.5
	shield = true
	$shieldTimer.start(2)
	
func _on_shieldTimer_timeout():
	shield = false
	if !isFrozen:
		speed = normalSpeed

func _on_effectTimer_timeout():
	speed = normalSpeed
	isFrozen = false
	selectSprite("normal")

func accelerate():
	set_state(accState)
	match isFrozen:
		true:
			speed = frozenSpeed
		false:
			speed = normalSpeed
	accelerating = true
	speedTimer.start(3)
	selectSprite("acc")

func _on_speedTimer_timeout():
	set_state(normalState)
	accTimer.start(1.5)

func _on_HurtBox_area_entered(area):
	if area.is_in_group("proyectiles"):
		$"efecto_daño".play()
		$AnimationPlayer.play("got_hit")
		get_hurt(area.damage)
		if area.attack_type == "ice":
			freeze()

func set_state(newState):
	normalSpeed = newState.normalSpeed
	frozenSpeed = newState.frozenSpeed

func _on_accTimer_timeout():
	accelerate()
