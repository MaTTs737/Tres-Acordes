extends Label

onready var origin = get_node("enemySpawner")

func _ready():
	text = str(origin.wave)
	

func _on_Timer_timeout():
	text = str(origin.wave)

