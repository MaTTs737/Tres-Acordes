extends Area2D

export (int) var speed

var attack_power = 10
var xLimit = 1641
var life
var maxLife = 1000

func _ready():
	life = maxLife

func _process(delta):
	global_position.x += speed * delta
	if global_position.x >= xLimit:
		Utils._get_main_node().player_life -= attack_power
		queue_free()

func get_hurt(damage):
	life -= damage
	if life <= 0 : 
		queue_free()

func _on_kameha_area_entered(area):
	if area.is_in_group("proyectiles"):
		get_hurt(area.damage)
