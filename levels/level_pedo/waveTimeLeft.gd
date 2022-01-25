extends Label

onready var origin = get_node("../../../../enemySpawner/waveTimer")


func _ready():
	text = str(origin.time_left)


func _on_Timer_timeout():
	text = str(origin.time_left)
