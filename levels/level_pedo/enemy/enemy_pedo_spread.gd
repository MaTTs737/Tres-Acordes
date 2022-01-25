extends KinematicBody2D

signal dead(offset)

onready var effectTimer = $effectTimer
onready var lifeRect = $lifeGreen

export (int) var drops

var maxLife = 20
var life setget set_life
var isFrozen = false
var speed
var normalSpeed
var frozenSpeed

func selectSprite(sprite : String):
	for i in $sprites.get_children():
		if i.name == sprite:
			i.visible = true
		else: i.visible = false
			
func _ready():
	selectSprite("normal")
	speed = normalSpeed
	frozenSpeed = normalSpeed/2
	set_life(maxLife)
	connect("dead",Utils._get_main_node().get_node("enemySpawner"),"spread")
	
func set_life(value):
	life=value
	var unit = $lifeRed.rect_size.x / maxLife
	$lifeGreen.rect_size.x = unit *life

func die ():
	Utils._get_main_node().coins += drops
	emit_signal("dead",get_parent().unit_offset)
	get_parent().queue_free()

func get_hurt (damage: int) -> void:
	life -= damage
	if life <= 0:
		die()

func _on_effectTimer_timeout():
	if isFrozen:
		speed = normalSpeed
		isFrozen=false
		selectSprite("normal")

func _on_HurtBox_area_entered(area):
	if area.is_in_group("proyectiles"):
		$"efecto_daño".play()
		$AnimationPlayer.play("got_hit")
		get_hurt(area.damage)
		if area.attack_type == "ice":
			freeze()

func freeze():
	effectTimer.start()
	if !isFrozen:
		speed /= 2
		isFrozen = true
		selectSprite("frozen")

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
