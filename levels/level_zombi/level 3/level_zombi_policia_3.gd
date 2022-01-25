extends Node2D

signal change_level (level_name)

export (String) var level_name = "horror"

onready var mira = $mira_pistola_linterna
onready var timer_reload = $Timer_reload
onready var revolver = $revolver

onready var camera = $Camera_zombie_3

onready var light = $mira_pistola_linterna/Light2D

onready var win_lose = $winLoseHandler

const Zedu_1 = preload("res://levels/level_zombi/level 3/Enemies/Zedu1/Zedu_l3_1.tscn")
const Zedu_2 = preload ("res://levels/level_zombi/level 3/Enemies/Zedu2/Zedu_l3_2.tscn")
const Zedu_3 = preload ("res://levels/level_zombi/level 3/Enemies/Zedu3/Zedu_l3_3.tscn")
const Zedu_4 = preload ("res://levels/level_zombi/level 3/Enemies/Zedu4/Zedu_l3_4.tscn")
const Zedu_kill = preload ("res://levels/level_zombi/level 3/assets/Animations/Zedu_l3_kill.tscn")

const TIRO = preload("res://levels/level_zombi/tiro.tscn")

const scary = preload ("res://levels/level_zombi/level 3/assets/Animations/ScaryD.tscn")

var can_shoot = false
var AMMO = 0
var camera_speed_x = 250
var light_intensity = 3

var edu_is_dead = false
var losing = false
var lost = false
var won = false

func _ready():
	$CanvasModulate.set_color(Color(0,0,0,1))
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	randomize()
	var revolver_pos = randi()%4
	match revolver_pos:
		0:
			revolver.position.x = rand_range(193,95)
			revolver.position.y = rand_range (402,438)
		1:
			revolver.position.y = rand_range(530.00,760.00)
			revolver.position.x = rand_range(-607.00,1645.00)
		2: 
			revolver.position.x = rand_range(932,1057)
			revolver.position.y = rand_range (375,355)
		3:
			revolver.position.x = rand_range(1112,1312)
			revolver.position.y = 593

func _process(delta: float) -> void:
	mira.position = get_global_mouse_position()
	
	if Input.is_action_pressed ("ui_left"):
		camera.position.x -= camera_speed_x * delta
	
	if Input.is_action_pressed("ui_right"):
		camera.position.x += camera_speed_x * delta
	
	
	if AMMO <= 0 or !can_shoot:
		if Input.is_action_just_pressed("attack_mouse"):
			$empty_gun.play()
		if Input.is_action_just_pressed("reload"):
			if timer_reload.is_stopped():
				timer_reload.start()
	
	
	if can_shoot and AMMO > 0:
		if Input.is_action_just_pressed("attack_mouse"):
			shoot()
			AMMO -= 1
	
	if light_intensity == 0 and !losing:
		losing = true
		kill_player()
		if lost == true:
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			win_lose.lose()
	
	if edu_is_dead and !won:
		won = true
		camera.start_tween()
		yield ($Camera_zombie_3/Tween,"tween_completed")
		$Camera_zombie_3/AnimationPlayer.play("check_room")
		yield($Camera_zombie_3/AnimationPlayer,"animation_finished")
		var scary_anim = scary.instance()
		add_child(scary_anim)
		scary_anim.connect("play_ending",self,"change_level")
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		get_tree().paused = true
#		win_lose.win()


func shoot():
	var tiro = TIRO.instance()
	tiro.position = get_global_mouse_position()
#	tiro.position = get_viewport().get_mouse_position()
	add_child(tiro)


func _on_Zedu_spawn_timeout() -> void:
	if edu_is_dead:
		return 
	randomize()
	var rand = randi()%5
	var Zedu
	match rand:
		0:
			return
		1:
			Zedu = Zedu_1.instance()
			add_child(Zedu)
			Zedu.position.y = rand_range(530.00,760.00)
			Zedu.position.x = rand_range(-607.00,1645.00)
			Zedu.connect("player_hurt",self,"on_player_hurt")
		2:
			Zedu = Zedu_2.instance()
			add_child(Zedu)
			Zedu.position.y = 0
			Zedu.position.x = rand_range(-607.00,1645.00)
			Zedu.connect("player_hurt",self,"on_player_hurt")
		3:
			Zedu = Zedu_3.instance()
			add_child(Zedu)
			Zedu.position.x = 321.925
			Zedu.position.y = 370.217
			Zedu_3.connect("player_hurt",self,"on_player_hurt")
		4:
			Zedu = Zedu_4.instance()
			add_child (Zedu)
			Zedu.position.x = 1401.84
			Zedu.position.y = 366.223
			Zedu_4.connect("player_hurt",self,"on_player_hurt")

func on_player_hurt () -> void:
	match light_intensity:
		3:
			light.set_energy(0.4)
			light_intensity = 2
		2:
			light.set_energy (0.3)
			light_intensity = 1
		1:
			light.set_energy(0.0)
			light_intensity = 0



func _on_revolver_area_entered(area: Area2D) -> void:
	if area.is_in_group("light"):
		AMMO = 15
		can_shoot = true
		revolver.queue_free()

func kill_player () -> void:
	var edu_kill = Zedu_kill.instance()
	edu_kill.position.x = camera.position.x
	add_child(edu_kill)
	
func change_level () -> void:
	emit_signal("change_level",level_name)
