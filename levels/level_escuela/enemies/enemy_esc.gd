extends KinematicBody2D

export (int) var speed
onready var timer = $Timer
onready var map = get_parent().get_node("Navigation2D/labTile")
onready var searchTimer = $searchTimer
onready var view_col = $view/CollisionShape2D
onready var view = $view
onready var flee_point = get_parent().get_node("flee_point").position

onready var lab_cells = []

export (int) var show 
var nav setget set_nav
var goal = Vector2()
var path = []
var state
var found = false
var dist
var fleeing = false

enum { WANDER, CHASE, SEE, APPROACH, FLEE } #ESTADOS DEL PERSONAJE

func set_nav(new_nav): #asigna navigation2D
	nav = new_nav

func update_path(): #reconstruye camino
	path = nav.get_simple_path(global_position, goal, false)

func update_goal(new_goal): #actualiza objetivo y llama a update_path
	goal = new_goal
	update_path()

func change_state(new_s):
	state = new_s

func _ready():
	load_lab()
	change_state(WANDER)
	randomize()

func _process(delta):
	move(state,delta)
	show = position.distance_to(map.get_player_pos())

func move(state,delta): #define destino segun estado y mueve hacia ahi
	match state:
		WANDER:
			random_wander(delta)
		CHASE:
			chase(delta)
		APPROACH:
			approach(delta)
		SEE:
			$senial_alerta.visible = true
			return
		FLEE:
			flee(delta) 

func random_wander(delta): #elige destino aleatorio del mapa
	
	if path.size()>1:
		var d = position.distance_to(path[0])
		if d > 10:
			position = position.linear_interpolate(path[0],(speed*delta)/d)
		else: path.remove(0)
	else: update_goal(map.map_to_world(Utils.choise_list(lab_cells)))

func chase(delta): #persigue al player; si se aleja mucho vuelve a random
	if path.size()>1:
		var d = position.distance_to(path[0])
		if d > 10 :
			position = position.linear_interpolate(path[0],(speed*delta*3)/d)
			var a = check_for_player()
			if a:
				update_goal(map.get_player_pos())
			else:
				change_state(WANDER)
		else: 
			path.remove(0)
	else: change_state(WANDER)

func check_for_player(): #verifica si el player esta dentro de la vision
	 return view.overlaps_body(Utils._get_main_node().get_node("player_esc"))
	
func _on_searchTimer_timeout():  #la funcion search es para crear animacion entre q te encuentra y te persigue
	$senial_alerta.visible = false
	if fleeing :
		change_state(FLEE)
	else:
		found = check_for_player()
		if found :
			update_goal(map.get_player_pos())
			change_state(CHASE)
		else: change_state(WANDER)
		found = false

func search(): 
	if searchTimer.is_stopped():
		searchTimer.start()

func _on_view_body_entered(body):
	fleeing = false
	change_state(SEE)
	search()

func approach(delta):
	if path.size()>1:
		var d = global_position.distance_to(path[0])
		if d > 10:
			global_position = global_position.linear_interpolate(path[0],(speed*delta)/d)
		else: path.remove(0)
	
func _on_switchWander_timeout(): #alterna entre approach y wander
	if state in [WANDER,APPROACH]:
		match state:
			WANDER:
				$switchWander.start(3)
				update_goal(map.get_edu_pos())
				change_state(APPROACH)
			APPROACH:
				$switchWander.start(10)
				change_state(WANDER)

func get_hurt():
	update_goal(flee_point)
	fleeing=true
	change_state(FLEE)
	print("hurt")

func flee(delta):
	if path.size()>1:
			var d = global_position.distance_to(path[0])
			if d > 10 :
				global_position = global_position.linear_interpolate(path[0],(speed*delta)/d)
			else: 
				path.remove(0)

func load_lab():
	for i in map.get_used_cells():
		if map.map_to_world(i).x > 344 and map.map_to_world(i).x < 672 and map.map_to_world(i).y < 312:
			pass
		else:
			lab_cells.append(i)
