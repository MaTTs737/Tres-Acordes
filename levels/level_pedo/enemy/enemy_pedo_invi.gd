extends KinematicBody2D

onready var effectTimer = $effectTimer
onready var lifeRect = $lifeGreen

export (int) var drops = 10
var maxLife = 20
var life setget set_life
var isFrozen = false
var speed
var normalSpeed
var frozenSpeed
var invi = false

func selectSprite(sprite : String):
	for i in $sprites.get_children():
		if i.name == sprite:
			i.visible = true
		else: i.visible = false

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
	$"efecto_daño".play()
	life -= damage
	if life <= 0:
		die()

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
		
func _on_effectTimer_timeout():
	if isFrozen:
		speed = normalSpeed
		isFrozen=false
		selectSprite("normal")

func _on_HurtBox_area_entered(area):
	if area.is_in_group("proyectiles"):
		get_hurt(area.damage)
		if area.attack_type == "ice":
			freeze()

func go_invi():
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled
	$HurtBox/CollisionShape2D.disabled = !$HurtBox/CollisionShape2D.disabled
	invi = !invi
	if invi:
		selectSprite("invi")
	else:
		selectSprite("normal")

func _on_inviTimer_timeout():
	go_invi()
