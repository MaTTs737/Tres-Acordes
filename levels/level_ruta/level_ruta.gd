extends Node

onready var player = $player
onready var ruta_start = $stage/ruta_start
onready var ruta_1 = $stage/ruta_1
onready var ruta_3 = $stage/ruta_3
onready var lifeLabel = $HUD/Control/HBoxContainer/lifeCountLabel
onready var scoreLabel = $HUD/Control/MarginContainer/HBox1/Hbox3/scoreCountLabel

var score : int

func _ready():
	player.setup(ruta_start.global_position)

func _on_player_switchL():
	player.position.x -= 150

func _on_player_switchR():
	player.position.x += 150

func _process(delta):
	if player.position.y > Utils.view_size.y or player.position.x >= ruta_3.position.x or player.position.x <= ruta_1.position.x or player.position.y <= 0:
		player.die(ruta_start.position)
	if player.life <= 0:
		player.die(ruta_start.position)
		player.life = player.maxLife
	score += 1
	scoreLabel.text = str(score)
	


func _on_player_life_changed():
		lifeLabel.text = str(player.life)
