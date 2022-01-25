extends Node2D

onready var enemy = $enemy_esc
onready var goalPos = $goalPos.position
onready var nav = $Navigation2D

func _ready():
	enemy.nav = nav


func _on_winArea_body_entered(body):
#	if body.is_in_group("enemies"):
#		$winLoseHandler.lose()
	pass

func _on_winTimer_timeout():
	$winLoseHandler.win()
