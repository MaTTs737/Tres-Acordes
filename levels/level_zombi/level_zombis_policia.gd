extends Node2D

onready var mira = $mira_pistola
onready var adriel = $adrielSpawner/adriel_zombi


var player_life = 1
var coins = 0

const TIRO = preload("res://levels/level_zombi/tiro.tscn")
const pausaScreen = preload("res://HUD/pausaScreen.tscn")

var shots = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(delta):
	if Input.is_action_just_pressed("pausa"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		var p = pausaScreen.instance()
		add_child(p)
	mira.position = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("attack_mouse"):
		shoot()

func shoot():
	var tiro = TIRO.instance()
	tiro.position = get_viewport().get_mouse_position()
	tiro.visible = false
	Utils._get_main_node().add_child(tiro)

func _on_adriel_zombi_area_entered(area):
	shots +=1
	if shots > 2:
		adriel.ocultar()
		shots = 0
	randomize()
	var desvio = randi()%4 + 1
	match desvio:
		1: 
			area.position.x += 75
		2:
			area.position.x-= 75
		3:
			area.position.y += 75
		4:
			area.position.y -= 75
	area.visible=true
	
