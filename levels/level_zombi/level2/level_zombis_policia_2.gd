extends Node2D


## modular los comportamientos de los enemigos (sacarlos del nivel), posiblemente lo mismo con el jugador

signal change_level (level_name)

export (String) var level_name = "level"

onready var camera = $Camera2D
onready var camera_tween = $Camera2D/Tween
onready var mira = $mira_pistola
onready var timer_shoot = $Timer_shoot
onready var timer_reload = $Timer_reload
onready var win_lose = $winLoseHandler
onready var ammo_count = $HUD_zombie/Control/MarginContainer/HBox1/Hbox3/AMMOcount



onready var J_life_count = $HUD_zombie/Control/Zjaique_life
onready var A_life_count = $HUD_zombie/Control/Zadriel_life


onready var Zadriel = $Z_adriel
onready var Zadriel_timer = $Timer_Zadriel

onready var pos_Zadriel1 = $Position_Zadriel1
onready var pos_Zadriel2 = $Position_Zadriel2
onready var pos_Zadriel3 = $Position_Zadriel3

onready var pos_list_Zadriel_x = [pos_Zadriel1.position.x,pos_Zadriel2.position.x,pos_Zadriel3.position.x]
onready var pos_list_Zadriel_y = [pos_Zadriel1.position.y,pos_Zadriel2.position.y,pos_Zadriel3.position.y]

onready var Zjaique = $Z_jaique

onready var open_door = $background/open_door


const Z_edu = preload ("res://levels/level_zombi/level2/enemies/Zedu/Z_edu.tscn")
const TIRO = preload("res://levels/level_zombi/tiro.tscn")
const pausaScreen = preload("res://HUD/pausaScreen.tscn")
const ball = preload ("res://levels/level_zombi/level2/enemies/Attacks/Acid/acid_ball.tscn")
const hurt_anim = preload ("res://levels/level_zombi/level2/assets/Animations/hurt_anim.tscn")


const camera_pos_hidden = Vector2 (0,780)
const camera_pos_up = Vector2 (0,0)

var AMMO = 8
var is_hidden = true
var player_life = 30
var can_shoot = true
var edu_attack = false

var won = false
var lost = false
var edu_kill


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_node("Camera2D").position = camera_pos_hidden
	
func _process(delta):
	if $ColorRect.rect_global_position != $Camera2D.global_position :
		$ColorRect.rect_global_position = $Camera2D.global_position
	if Input.is_action_just_pressed("pausa"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Utils._get_level().paused = true
		var p = pausaScreen.instance()
		add_child(p)
		
	mira.position = get_viewport().get_mouse_position()
	
	if AMMO <= 0:
		if Input.is_action_just_pressed("attack_mouse"):
			$empty_gun.play()
		if Input.is_action_just_pressed("reload"):
			if timer_reload.is_stopped():
				$carga_pistola.play()
				timer_reload.start()


	if can_shoot and AMMO > 0:
		if Input.is_action_just_pressed("attack_mouse"):
			shoot()
			AMMO -= 1
	
	
	if Input.is_action_just_pressed("ui_up"):
		camera.start_tween_up()
		is_hidden = false
		if edu_attack:
			edu_kill=Z_edu.instance()
			add_child(edu_kill)



	if Input.is_action_just_released("ui_up") and !edu_attack and !won:
		camera.start_tween_down()
		is_hidden = true
		$Timer_cagon.start()
	
	
	J_life_count.text = str(Zjaique.Zjaique_life)
	A_life_count.text = str(Zadriel.Zadriel_life)      #corregir y hacer con una señal para que no se procese todo el tiempo
	
	
	ammo_count.text = str(AMMO)                       # lo mismo con las balas
	
	
	if Zadriel.is_dead and Zjaique.is_dead and !won:
		won = true
		$HUD_zombie/Control.hide()
		$get_creepy.play("get_creepy")
	
#	if Zadriel.is_dead and Zjaique.is_dead and !won:
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		get_tree().paused = true
#		won = true
#		win_lose.win()
	
	if player_life <= 0 and !lost:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		lost = true
		win_lose.lose()


func shoot():
	var tiro = TIRO.instance()
	tiro.position = get_viewport().get_mouse_position()
	Utils._get_level().add_child(tiro)
	can_shoot = false
	timer_shoot.start()



func _on_Timer_Zadriel_timeout() -> void:
	randomize()
	var rand = randi()%3
	Zadriel.position.x = pos_list_Zadriel_x [rand]
	Zadriel.position.y = pos_list_Zadriel_y [rand]



func _on_Timer_shoot_timeout() -> void:
	can_shoot = true


func _on_Timer_reload_timeout() -> void:
	AMMO = 8


func _on_Timer_cagon_timeout() -> void:
	if is_hidden:
		edu_attack = true


func _on_Timer_ball_timeout() -> void:
	randomize()
	var amount = randi()%2
	for i in amount:
		var b = ball.instance()
		add_child(b)



func is_player_hurt() -> void:
	$ColorRect/AnimationPlayer.play("hurt")

func change_level () -> void:
#	$CanvasModulate.visible = false
	emit_signal("change_level",level_name)

func _on_door_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !won:
		return
	if event is InputEventMouseButton and event.get_button_index() == 2 :
		open_door.play()
		yield(open_door,"finished")
		change_level()
