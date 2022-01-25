extends Node

onready var current_level = $Intro


func _ready() -> void:
	$Intro.connect("change_level",self,"handle_level_change")
	
	
func handle_level_change (current_level_name: String) -> void:
	print("works")
	var next_level
	match current_level_name:
		"intro":
			next_level = load ("res://levels/level_zombi/level 1/level_zombis_policia.tscn")
		"entertainer":
			next_level = load ("res://levels/level_zombi/Cutscenes/Cutscene_1.tscn")
		"cutscene1":
			next_level = load ("res://levels/level_zombi/level2/level_zombis_policia_2.tscn")
		"skill":
			next_level = load ("res://levels/level_zombi/level 3/level_zombi_policia_3.tscn")
		"horror":
			next_level = load ("res://levels/level_zombi/Cutscenes/Outro.tscn")
		_:
			return
	remove_child(current_level)
	current_level.queue_free()
	next_level = next_level.instance()
	add_child(next_level)
	next_level.connect("change_level",self,"handle_level_change")
	current_level = next_level

