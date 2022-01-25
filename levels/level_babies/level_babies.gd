extends Node2D

onready var fondo = $fondo
onready var pantalla = $pantalla
onready var paleta = $YSort/paleta

var babies_hit = 0

const BB = preload("res://levels/level_babies/baby.tscn") 
	
func _process(delta):
	if babies_hit > 3:
		$game/Control.show()

func spawn_baby():
	var baby = BB.instance()
	baby.position = Vector2(rand_range(100,Utils._get_view_size().x-100),100)
	$YSort.add_child(baby)

func _on_spawnTimer_timeout():
	spawn_baby()
	$spawnTimer.start(2)

func baby_hit():
	babies_hit += 1

func _on_Button_pressed():
	get_tree().change_scene("res://HUD/menu.tscn")


func _on_presAP_finished():
	$backgroundAP.play()
	pantalla.hide()
	fondo.show()
	paleta.show()
	$spawnTimer.start()
