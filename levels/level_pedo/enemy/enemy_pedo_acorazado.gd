extends KinematicBody2D

onready var effectTimer = $effectTimer
onready var lifeRect = $lifeGreen

export (int) var drops

var maxLife = 20
var life setget set_life
var isFrozen = false
var acorazado = true
var coraza_life_init = 500
var coraza_life = 500
var speed
var normalSpeed
var frozenSpeed
var currentStage = 1

func selectSprite(sprite : String):
	for i in $sprites.get_children():
		if i.name == sprite:
			i.visible = true
		else: i.visible = false

func _process(_delta):
	pass

func _ready():
	speed = normalSpeed
	frozenSpeed = normalSpeed/2
	set_life(maxLife)
	
func set_life(value):
	life=value
	var unit = $lifeRed.rect_size.x / maxLife
	$lifeGreen.rect_size.x = unit *life

func die ():
	Utils._get_main_node().coins += drops
	get_parent().queue_free()

func get_hurt (damage: int) -> void:
	if acorazado:
		coraza_life -= damage
		if coraza_life <= 0:
			acorazado = false
			currentStage = 4
			selectSprite("descora")
		elif coraza_life <= coraza_life_init * 0.33:
			currentStage = 3
			selectSprite("normal3")
		elif coraza_life <= coraza_life_init*0.66:
			currentStage = 2
			selectSprite("normal2")

	else:
		life -= damage
		if life <= 0:
			die()

func freeze():
	effectTimer.start()
	if !isFrozen:
		speed /= 2
		isFrozen = true
		match currentStage:
			1: selectSprite("frozen1")
			2: selectSprite("frozen2")
			3: selectSprite("frozen3")
			4: selectSprite("frozen_des")

var shield = false

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
	if isFrozen:
		speed = normalSpeed
		isFrozen=false
		match currentStage:
			1: selectSprite("normal1")
			2: selectSprite("normal2")
			3: selectSprite("normal3")

func _on_HurtBox_area_entered(area):
	if area.is_in_group("proyectiles"):
		$"efecto_daño".play()
		$AnimationPlayer.play("got_hit")
		if acorazado:
			if area.attack_type == "hard":
				get_hurt(area.damage)
			else:
				get_hurt(area.damage*0.4)
		else:
			get_hurt(area.damage)
			if area.attack_type == "ice":
				freeze()

