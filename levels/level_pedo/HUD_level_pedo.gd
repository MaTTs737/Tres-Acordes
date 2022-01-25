extends CanvasLayer

onready var lifeCountLabel = $Control/MarginContainer/HBox1/Hbox2/lifeRect/lifeCountLabel
onready var scoreCountLabel = $Control/MarginContainer/HBox1/Hbox3/scoreCountLabel
onready var tucaCountLabel = $Control/MarginContainer/HBox1/Hbox2/tucaRect/tucaCpuntLab
onready var control = $Control
onready var timer = $Timer


var score = 0 setget set_score
var tucas = 0 setget set_tucas

func update_start():
	set_score(AbstractPlayer.score)
	
func set_score(value):
	scoreCountLabel.text= str(value)

func set_tucas(value):
	tucaCountLabel.text = str (value)

func _on_Button_pressed():
	get_tree().change_scene("res://HUD/menu.tscn")

func _on_player_tile_life_changed(life):
	lifeCountLabel.text = str(life)
	showHUD()

func _on_Timer_timeout():
	control.hide()

func _process(delta):
	if Input.is_action_just_pressed("showHUD"):
		showHUD()

func showHUD():
	control.show()
	timer.start(2)
